#!/usr/bin/env bash

# Run a command with its original terminal streams, then report its result.
# Deliberately avoid `set -e`: a failed command must still trigger a notification.

usage() {
    cat <<'EOF'
Usage: notify-run.sh [options] -- commande [arguments...]

Exécute la commande, notifie sa fin et conserve son code de retour.

Options :
  -s, --success MESSAGE  Message en cas de succès (code 0).
  -e, --error MESSAGE    Message en cas d'échec (code non nul).
  -b, --backend NOM      desktop (par défaut), pushover ou ntfy.
  -h, --help             Affiche cette aide.

Messages par défaut :
  Succès : « commande : terminé avec succès »
  Échec  : « commande : échec (code N) »

Configuration par variables d'environnement :
  NOTIFY_RUN_BACKEND     Backend par défaut, remplacé par --backend.
  PUSHOVER_USER          Clé utilisateur Pushover.
  PUSHOVER_TOKEN         Jeton d'application Pushover.
  NTFY_URL              URL complète du sujet, ex. https://ntfy.sh/mon-sujet.
  NTFY_TOKEN            Jeton ntfy, facultatif selon le serveur/sujet.

desktop nécessite notify-send et un service de notifications de bureau.
pushover et ntfy nécessitent curl ; chaque envoi est limité à 10 secondes.
Un échec de notification est signalé sur stderr sans changer le code de retour.
Les messages fournis sont utilisés tels quels, y compris s'ils sont vides.

Exemples :
  notify-run.sh -- make build
  notify-run.sh -s 'Compilation terminée' -e 'Compilation échouée' -- make
  notify-run.sh -b pushover -- ./backup.sh
  notify-run.sh -- bash -o pipefail -c 'generate | compress > archive.gz'
EOF
}

usage_error() {
    printf 'notify-run: %s\nVoir --help pour la syntaxe.\n' "$1" >&2
    exit 2
}

backend=${NOTIFY_RUN_BACKEND:-pushover}
success_message=
error_message=
success_set=false
error_set=false

while (( $# )); do
    case $1 in
        -s|--success)
            (( $# >= 2 )) || usage_error "Message manquant pour $1."
            success_message=$2
            success_set=true
            shift 2
            ;;
        -e|--error)
            (( $# >= 2 )) || usage_error "Message manquant pour $1."
            error_message=$2
            error_set=true
            shift 2
            ;;
        -b|--backend)
            (( $# >= 2 )) || usage_error "Backend manquant pour $1."
            backend=$2
            shift 2
            ;;
        -h|--help)
            usage
            exit 0
            ;;
        --)
            shift
            break
            ;;
        *) usage_error "Option inconnue : $1 (placer la commande après --)." ;;
    esac
done

(( $# )) || usage_error 'Commande manquante.'
case $backend in
    desktop|pushover|ntfy) ;;
    *) usage_error "Backend inconnu : $backend." ;;
esac

notify() {
    local response
    local -a curl_args=(--fail --silent --show-error --connect-timeout 5 --max-time 10)

    case $backend in
        desktop)
            notify-send --app-name=notify-run --urgency="$urgency" -- "$title" "$message"
            ;;
        pushover)
            if [[ -z ${PUSHOVER_USER:-} || -z ${PUSHOVER_TOKEN:-} ]]; then
                printf 'notify-run: PUSHOVER_USER et PUSHOVER_TOKEN sont requis.\n' >&2
                return 1
            fi
            response=$(curl "${curl_args[@]}" \
                --form-string "token=$PUSHOVER_TOKEN" \
                --form-string "user=$PUSHOVER_USER" \
                --form-string "title=$title" \
                --form-string "message=$message" \
                https://api.pushover.net/1/messages.json) || return 1
            # Pushover also reports acceptance in the JSON response body.
            [[ $response =~ \"status\"[[:space:]]*:[[:space:]]*1[[:space:]]*[,}] ]]
            ;;
        ntfy)
            if [[ -z ${NTFY_URL:-} ]]; then
                printf 'notify-run: NTFY_URL est requis.\n' >&2
                return 1
            fi
            if [[ -n ${NTFY_TOKEN:-} ]]; then
                curl_args+=(--header "Authorization: Bearer $NTFY_TOKEN")
            fi
            # stdin preserves literal messages, including a leading @.
            printf '%s' "$message" | curl "${curl_args[@]}" \
                --header "Title: $title" --data-binary @- -- "$NTFY_URL" >/dev/null
            ;;
    esac
}

# Defer SIGINT handling while the foreground command handles Ctrl-C itself,
# allowing its exit status to be reported when it returns.
trap ':' INT
"$@"
command_status=$?
trap - INT

command_name=${1##*/}
if (( command_status == 0 )); then
    title='Commande terminée'
    urgency=normal
    if [[ $success_set == true ]]; then
        message=$success_message
    else
        message="$command_name : terminé avec succès"
    fi
else
    title='Échec de la commande'
    urgency=critical
    if [[ $error_set == true ]]; then
        message=$error_message
    else
        message="$command_name : échec (code $command_status)"
    fi
fi

if ! notify; then
    printf 'notify-run: échec de la notification (%s).\n' "$backend" >&2
fi
exit "$command_status"
