#!/usr/bin/env bash
set -euo pipefail

DP1_STATUS="disconnected"

for f in /sys/class/drm/card*-DP-1/status; do
  [[ -e "$f" ]] || continue
  DP1_STATUS="$(<"$f")"
  break
done

if [[ "$DP1_STATUS" == "connected" ]]; then
  hyprctl --batch 'keyword monitor DP-1,3840x2160@165.00,0x0,2 ; keyword monitor eDP-1,disable'
else
  hyprctl --batch 'keyword monitor eDP-1,preferred,0x0,1'
fi
