#!/bin/sh

music_root="${MPLAYER_MUSIC_ROOT:-$HOME/Music}"
dotfiles_root="${DOTFILES:-$HOME/dev/personal/dotfiles}"
playlists_root="$music_root/playlists"
rofi_config="$dotfiles_root/rofi/mplayer.rasi"
kitty_app_id='e2696752-512f-11f0-ae75-ab75b60c01aa'

fail() {
  message=$1
  printf 'mplayer-playlist-open: %s\n' "$message" >&2

  if command -v notify-send >/dev/null 2>&1; then
    notify-send -u critical "Playlist opening failed" "$message" >/dev/null 2>&1 || :
  fi

  exit 1
}

command -v rofi >/dev/null 2>&1 || fail "Command not found: rofi"
command -v kitty >/dev/null 2>&1 || fail "Command not found: kitty"
command -v vim >/dev/null 2>&1 || fail "Command not found: vim"

[ -d "$playlists_root" ] || fail "Directory not found: $playlists_root"
[ -r "$rofi_config" ] || fail "Rofi configuration not found: $rofi_config"

playlist_listing=$(
  find "$playlists_root" -maxdepth 1 -type f -iname '*.m3u' -printf '%f\n' |
    LC_ALL=C sort -f
)

[ -n "$playlist_listing" ] || fail "No M3U playlist found in: $playlists_root"

selected_playlist=$(
  printf '%s\n' "$playlist_listing" |
    rofi -p "edit playlist" -dmenu -i -no-custom -l 10 -config "$rofi_config"
) || exit 0

[ -n "$selected_playlist" ] || exit 0

case "$selected_playlist" in
  */*) fail "Invalid playlist name: $selected_playlist" ;;
esac

playlist_path="$playlists_root/$selected_playlist"
[ -f "$playlist_path" ] || fail "Playlist not found: $selected_playlist"

exec kitty --app-id "$kitty_app_id" vim -- "$playlist_path"
