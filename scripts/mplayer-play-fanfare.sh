# file="$(find /home/yul/Music/playlists/ -maxdepth 1 | sed "s|^/home/yul/Music/||" | sort | rofi -p "play" -dmenu -i -l 10 -config $DOTFILES/rofi/mplayer.rasi)" || exit 0
. "$DOTFILES/scripts/mplayer-save-state.sh"
f="music/1995 - Yasunori Mitsuda - Chrono Trigger/120 Fanfare 1.mp3\nmusic/1994 - Nobuo Uematsu - Final Fantasy VI/106 Fanfare.mp3"
mpc add "$(printf '%b' "$f" | shuf -n 1)"
mpc play
