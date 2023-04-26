#!/bin/sh

# reintializing keymaps
setxkbmap

# mapping Caps_Lock to Hyper_L
# keycode 66 = Caps_Lock
xmodmap -e 'keycode 66 = Hyper_L'
xmodmap -e 'remove lock = Hyper_L'
xmodmap -e 'remove Mod4 = Hyper_L'
xmodmap -e 'remove Mod4 = Hyper_L'
xmodmap -e 'add Mod3 = Hyper_L'

# mapping Caps_Lock only to Escape
pgrep xcape | xargs -I '{}' /bin/sh -c 'kill -9 {}'
xcape -e 'Hyper_L=Escape'

# mapping Alt_L to Super_L
# keycode 64 = Alt_L
xmodmap -e 'clear Mod1'
xmodmap -e 'clear Mod4'
xmodmap -e 'keycode 64 = Super_L'
# mapping Alt_R to Super_R
# keycode 108 = Alt_R
# xmodmap -e 'keycode 108 = Super_R'
# mapping Super_L to Alt_L
# keycode 133 = Super_L to Alt_L
xmodmap -e 'keycode 133 = Alt_L'

xmodmap -e 'keycode 108= Multi_key'

# recreating mod groups
xmodmap -e 'add Mod4 = Super_L Super_R'
xmodmap -e 'add Mod1 = Alt_L'

xmodmap -e 'keycode 65 = space Return space'
