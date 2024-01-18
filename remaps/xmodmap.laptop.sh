#!/bin/sh

# reintializing keymaps
setxkbmap

xmodmap -e 'remove Mod2 = Num_Lock'
xmodmap -e 'clear Lock'

# alt_l (keycode 64) -> super_l
xmodmap -e 'remove Mod1 = Alt_L'
# super_l (keycode 133) -> alt_l
xmodmap -e 'remove Mod4 = Super_L'
xmodmap -e 'keycode 64 = Super_L'
xmodmap -e 'keycode 133 = Alt_L'
xmodmap -e 'add Mod4 = Super_L'
xmodmap -e 'add Mod1 = Alt_L'

# caps lock (keycode 66) -> hyper
xmodmap -e 'keycode 66 = Hyper_L'
xmodmap -e 'remove lock = Hyper_L'
xmodmap -e 'remove Mod4 = Hyper_L'
xmodmap -e 'add Mod3 = Hyper_L'
# alt gr (keycode 108) -> super_r
xmodmap -e 'remove Mod1 = Alt_R'
xmodmap -e 'keycode 108 = Super_R'
xmodmap -e 'add Mod4 = Super_R'
# menu (keycode 135) -> compose (alt_r)
xmodmap -e 'keycode 135 = Multi_key'
