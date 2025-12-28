#!/usr/bin/env sh
# $FILE = chemin relatif au music_directory de MPD (ex: "Artist/Album/01 - Track.flac")

dir="$(dirname -- "$FILE")"
folder="$(basename -- "$dir")"

# Si le fichier est à la racine du music_directory
[ "$dir" = "." ] && folder="."

# Écrit un sticker "folder" sur CE morceau
rmpc sticker set "$FILE" "folder" "$folder" >/dev/null 2>&1 || true
