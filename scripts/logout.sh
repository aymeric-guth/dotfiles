#!/bin/sh

kill -9 "$(pgrep tmux)"
hyprctl dispatch exit
