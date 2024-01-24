#!/bin/sh

# reintializing keymaps
setxkbmap

# reset caps lock state to off
# reset num lock state to off
xmodmap -e 'clear Lock'
xmodmap -e 'clear Mod2'

# caps remapped to esc -> Meta_L ?
# caps lock (keycode 66) -> hyper
xmodmap -e 'remove Mod4 = Hyper_L'
xmodmap -e 'keycode 66 = Hyper_L'
xmodmap -e 'add Mod3 = Hyper_L'

# alt_r (keycode 108) -> compose key
#xmodmap -e 'remove Mod1 = Alt_R'
# xmodmap -e 'keycode 108 = Alt_R'
# xmodmap -e 'keysym Alt_R = Multi_key'
