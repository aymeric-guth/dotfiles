#!/bin/sh

notify-send "$(mpc status | sed 2,3d)"
