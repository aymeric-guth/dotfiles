#!/bin/sh

systemctl --user stop mpd
cp "$HOME"/.local/state/mpd/state /tmp/mpd_state
systemctl --user start mpd
