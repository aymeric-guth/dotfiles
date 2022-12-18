#apt-cache search '' | sort | cut --delimiter ' ' --fields 1 | fzf --multi --cycle --reverse --preview 'apt-cache show {1}' | xargs -r sudo apt install -y

finder() {
	formater="formater-$(uname -s)-$(uname -m)"
	[ ! -x "$DOTFILES/bin/$formater" ] && return 1
	rg --color=always --line-number --no-heading --smart-case . "$OBSIDIAN_VAULT/200 Areas/01_CheatSheet" |
		fzf --ansi \
			--color "hl:-1:underline,hl+:-1:underline:reverse" \
			--delimiter : \
			--preview 'bat --color=always {1} --highlight-line {2}' \
			--preview-window 'up,99%,border-bottom,+{2}+3/3,~3' \
			--print0 | "$formater" ':' '2' | xclip -i -selection clipboard
	# pbcopy
}

# ch - browse chrome history
ch() {
	prev="$PWD"
	cd "$DEV"/personal/yt_hist || return 1
	cols="$((COLUMNS / 3))"
	sep='{::}'
	python main.py "$COLUMNS" "$sep" |
		awk -F $sep '{printf "%-'$cols's  \x1b[36m%s\x1b[m\n", $1, $2}' |
		fzf --ansi --multi |
		sed 's#.*\(https*://\)#\1#' |
		xargs open
	cd "$prev" || return 1
}

chf() {
	# https://gist.github.com/dshnkao/10865f32d69e40dc591e08e3af970e9d
	local cols sep
	cols=$((COLUMNS / 3))
	sep='{::}'

	historyfile="$HOME/.mozilla/firefox/z6833bcl.default-release/places.sqlite"
	[ ! -f "$historyfile" ] && return 1 || cp "$historyfile" /tmp/h
	DB_PATH=/tmp/h

	QUERY="
  SELECT
      url, title FROM moz_places
  WHERE
      url NOT LIKE '%google%search%'
  ORDER BY
      visit_count DESC,
      last_visit_date DESC;
  "

	SEP="∙"

	ENTRY=$(
		sqlite3 "$DB_PATH" "$QUERY" |
			sed -E 's/^https?:\/\///' |
			sed -E "s/\\/?\\|/ $SEP /" |
			sed -E "s/$SEP $//" |
			fzf
	)

	URL=$(echo "$ENTRY" | sed "s/$SEP.*//g")
	[ -z "$URL" ] && return 0 || open "https://$URL"
}
