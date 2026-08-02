#!/bin/sh

music_root="${MPLAYER_MUSIC_ROOT:-$HOME/Music}"
dotfiles_root="${DOTFILES:-$HOME/dev/personal/dotfiles}"
rofi_config="$dotfiles_root/rofi/mplayer.rasi"

fail() {
  message=$1
  printf 'mplayer-playlist-edit: %s\n' "$message" >&2

  if command -v notify-send >/dev/null 2>&1; then
    notify-send -u critical "Playlist update failed" "$message" >/dev/null 2>&1 || :
  fi

  exit 1
}

notify_success() {
  title=$1
  message=$2

  if command -v notify-send >/dev/null 2>&1; then
    notify-send "$title" "$message" >/dev/null 2>&1 || :
  fi
}

choose() {
  prompt=$1
  rofi -p "$prompt" -dmenu -i -l 10 -config "$rofi_config"
}

command -v fd >/dev/null 2>&1 || fail "Command not found: fd"
command -v rofi >/dev/null 2>&1 || fail "Command not found: rofi"
command -v realpath >/dev/null 2>&1 || fail "Command not found: realpath"

music_root=$(realpath -e -- "$music_root" 2>/dev/null) ||
  fail "Music directory not found: $music_root"
library_root=$(realpath -e -- "$music_root/music" 2>/dev/null) ||
  fail "Directory not found: $music_root/music"
playlists_root=$(realpath -e -- "$music_root/playlists" 2>/dev/null) ||
  fail "Directory not found: $music_root/playlists"

[ -d "$library_root" ] || fail "Not a directory: $library_root"
[ -d "$playlists_root" ] || fail "Not a directory: $playlists_root"

selected_directory=$(
  fd --type=directory . "$library_root" |
    while IFS= read -r path; do
      printf 'music/%s\n' "${path#"$library_root"/}"
    done |
    sort |
    choose "add directory"
) || exit 0

[ -n "$selected_directory" ] || exit 0

case "$selected_directory" in
  music/*) directory_name=${selected_directory#music/} ;;
  *) fail "Invalid music directory: $selected_directory" ;;
esac

directory_path=$(realpath -e -- "$library_root/$directory_name" 2>/dev/null) ||
  fail "Directory not found: $selected_directory"

case "$directory_path" in
  "$library_root"/*) ;;
  *) fail "Directory is outside Music/music: $selected_directory" ;;
esac

[ -d "$directory_path" ] || fail "Not a directory: $selected_directory"

work_directory=''
output_file=''

cleanup() {
  if [ -n "$work_directory" ]; then
    rm -f -- "$work_directory/tracks" "$work_directory/listing" "$work_directory/sorted"
    rmdir -- "$work_directory" 2>/dev/null || :
  fi

  [ -z "$output_file" ] || rm -f -- "$output_file"
}

trap cleanup EXIT
trap 'exit 1' HUP INT TERM

work_directory=$(mktemp -d "${TMPDIR:-/tmp}/mplayer-playlist-edit.XXXXXX") ||
  fail "Could not create a temporary directory"

if ! find "$directory_path" -type f \( \
  -iname '*.aac' -o \
  -iname '*.aif' -o \
  -iname '*.aiff' -o \
  -iname '*.alac' -o \
  -iname '*.ape' -o \
  -iname '*.dff' -o \
  -iname '*.dsf' -o \
  -iname '*.flac' -o \
  -iname '*.m4a' -o \
  -iname '*.mka' -o \
  -iname '*.mp3' -o \
  -iname '*.mpc' -o \
  -iname '*.oga' -o \
  -iname '*.ogg' -o \
  -iname '*.opus' -o \
  -iname '*.wav' -o \
  -iname '*.wma' -o \
  -iname '*.wv' \
\) -print >"$work_directory/tracks"; then
  fail "Could not enumerate: $selected_directory"
fi

[ -s "$work_directory/tracks" ] ||
  fail "No music files found in: $selected_directory"

while IFS= read -r track_path || [ -n "$track_path" ]; do
  case "$track_path" in
    "$library_root"/*)
      printf 'music/%s\n' "${track_path#"$library_root"/}"
      ;;
    *)
      fail "Track is outside Music/music: $track_path"
      ;;
  esac
done <"$work_directory/tracks" >"$work_directory/listing"

selected_playlist=$(
  fd --max-depth=1 --type=file --extension=m3u . "$playlists_root" |
    while IFS= read -r path; do
      printf '%s\n' "${path##*/}"
    done |
    sort |
    choose "append to playlist"
) || exit 0

[ -n "$selected_playlist" ] || exit 0

case "$selected_playlist" in
  playlists/*) playlist_name=${selected_playlist#playlists/} ;;
  *) playlist_name=$selected_playlist ;;
esac

case "$playlist_name" in
  */*) fail "Playlist name must not contain a directory: $selected_playlist" ;;
esac

case "$playlist_name" in
  *.[mM]3[uU]) ;;
  *) playlist_name="$playlist_name.m3u" ;;
esac

playlist_path="$playlists_root/$playlist_name"

if [ -e "$playlist_path" ] && [ ! -f "$playlist_path" ]; then
  fail "Not a playlist file: $playlist_name"
fi

if [ -f "$playlist_path" ]; then
  if ! sed -e 's/\r$//' -e '/^[[:space:]]*$/d' "$playlist_path" >>"$work_directory/listing"; then
    fail "Could not read playlist: $playlist_name"
  fi
fi

if ! LC_ALL=C sort "$work_directory/listing" >"$work_directory/sorted"; then
  fail "Could not sort playlist: $playlist_name"
fi

while IFS= read -r track || [ -n "$track" ]; do
  case "$track" in
    music/*) ;;
    *) fail "Invalid track in $playlist_name: $track" ;;
  esac

  track_path=$(realpath -e -- "$music_root/$track" 2>/dev/null) ||
    fail "Track not found: $track"

  case "$track_path" in
    "$library_root"/*) ;;
    *) fail "Track is outside Music/music: $track" ;;
  esac

  [ -f "$track_path" ] || fail "Track not found: $track"
done <"$work_directory/sorted"

output_file=$(mktemp "$playlists_root/.mplayer-playlist-edit.XXXXXX") ||
  fail "Could not create the playlist: $playlist_name"

if ! cp -- "$work_directory/sorted" "$output_file"; then
  fail "Could not write playlist: $playlist_name"
fi

if [ -f "$playlist_path" ]; then
  chmod --reference="$playlist_path" "$output_file" ||
    fail "Could not preserve playlist permissions: $playlist_name"
else
  chmod 0644 "$output_file" || fail "Could not set playlist permissions: $playlist_name"
fi

mv -f -- "$output_file" "$playlist_path" ||
  fail "Could not save playlist: $playlist_name"
output_file=''

added_count=$(wc -l <"$work_directory/tracks" | tr -d '[:space:]')
total_count=$(wc -l <"$playlist_path" | tr -d '[:space:]')
message="$added_count tracks added, $total_count tracks total"

# printf 'Updated playlists/%s (%s)\n' "$playlist_name" "$message"
notify_success "Playlist updated: $playlist_name" "$message"
