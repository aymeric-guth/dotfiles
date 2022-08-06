#!/bin/sh

tmux new-session -s Main -n Audio -d;
tmux new-window -t Main -n Video -d;
tmux send-keys -t Main:Audio "flX" Enter;
tmux send-keys -t Main:Video "av" Enter;
tmux new-window -t Main -n Random -d;
tmux -u attach -t Main;
