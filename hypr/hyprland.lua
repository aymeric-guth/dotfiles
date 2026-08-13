----------------
--- MONITORS ---
----------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
-- hl.monitor({ output = "", mode = "preferred", position = "auto", scale = "auto" })
-- hl.on("hyprland.start", function()
--     hl.exec_cmd("~/dev/personal/dotfiles/scripts/reload.sh")
-- end)

local function configure_monitors()
  if hl.get_monitor('DP-1') then
    hl.monitor({ output = 'DP-1', mode = '3840x2160@165.00', position = '0x0', scale = 2 })
    hl.monitor({ output = 'eDP-1', disabled = true })
  else
    hl.monitor({ output = 'eDP-1', mode = 'preferred', position = '0x0', scale = 1.5 })
  end
end

configure_monitors()
hl.on('monitor.added', configure_monitors)
hl.on('monitor.removed', configure_monitors)

-------------------
--- MY PROGRAMS ---
-------------------

-- Quand le profil est en "performance", la température monte à 95 °C.
hl.exec_cmd('powerprofilesctl set performance')
hl.exec_cmd(
  [[hyprctl hyprpaper wallpaper 'eDP-1, /home/yul/Pictures/Screens/EEyWG-UU4AAnQRg.jpeg']]
)
hl.exec_cmd([[hyprctl hyprpaper wallpaper 'DP-1, /home/yul/Pictures/Screens/EEyWG-UU4AAnQRg.jpeg']])
hl.exec_cmd('hyprsunset --temperature 5500')

-----------------
--- AUTOSTART ---
-----------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/
hl.on('hyprland.start', function()
  hl.exec_cmd('hyprpaper')
  -- hl.exec_cmd("systemctl --user start hyprpolkitagent")
  hl.exec_cmd('mako')
  hl.exec_cmd('waybar')
  hl.exec_cmd('hyprpm reload -n')
end)

-----------------------------
--- ENVIRONMENT VARIABLES ---
-----------------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/
hl.env('XDG_CURRENT_DESKTOP', 'Hyprland')
hl.env('XDG_SESSION_TYPE', 'wayland')
hl.env('XDG_SESSION_DESKTOP', 'Hyprland')

hl.env('XCURSOR_SIZE', '24')
-- hl.env("XCURSOR_THEME", "")
hl.env('HYPRCURSOR_SIZE', '24')
-- hl.env("GTK_THEME", "")

hl.env('QT_QPA_PLATFORM', 'wayland')
-- hl.env("QT_STYLE_OVERRIDE", "kvantum")
-- hl.env("QT_QPA_PLATFORMTHEME", "qt5ct")
-- hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env('QT_QPA_PLATFORMTHEME', 'kde')
hl.env('QT_QPA_PLATFORM', 'wayland')
hl.env('XDG_MENU_PREFIX', 'plasma-')

-- hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "true")
-- hl.env("QT_SCALE_FACTOR", "2")
-- hl.env("QT_QPA_PLATFORMTHEME", "qt5ct")

hl.env('DOTFILES', '/home/yul/dev/personal/dotfiles')

-------------------
--- PERMISSIONS ---
-------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Permissions/
-- Permission changes require a Hyprland restart and are not applied on-the-fly.
hl.permission({ binary = '/usr/(bin|local/bin)/hyprpm', type = 'plugin', mode = 'allow' })

-- hl.config({
--     ecosystem = {
--         enforce_permissions = true,
--     },
-- })

-- hl.permission({ binary = "/usr/(bin|local/bin)/grim", type = "screencopy", mode = "allow" })
-- hl.permission({
--     binary = "/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland",
--     type = "screencopy",
--     mode = "allow",
-- })

---------------------
--- LOOK AND FEEL ---
---------------------

-- See https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
  general = {
    gaps_in = 1,
    gaps_out = 1,
    border_size = 1,

    col = {
      active_border = {
        colors = { 'rgba(33ccffee)', 'rgba(00ff99ee)' },
        angle = 45,
      },
      inactive_border = 'rgba(595959aa)',
    },

    -- Enable resizing windows by clicking and dragging on borders and gaps.
    resize_on_border = false,

    -- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/
    allow_tearing = false,
    layout = 'dwindle',
  },

  decoration = {
    rounding = 0,
    rounding_power = 0,
    active_opacity = 1.0,
    inactive_opacity = 1.0,

    shadow = {
      enabled = false,
      range = 4,
      render_power = 3,
      color = 'rgba(1a1a1aee)',
    },

    blur = {
      enabled = true,
      size = 3,
      passes = 1,
      vibrancy = 0.1696,
    },
  },

  animations = {
    enabled = false,
  },
})

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve('easeOutQuint', { type = 'bezier', points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve('easeInOutCubic', { type = 'bezier', points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve('linear', { type = 'bezier', points = { { 0, 0 }, { 1, 1 } } })
hl.curve('almostLinear', { type = 'bezier', points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve('quick', { type = 'bezier', points = { { 0.15, 0 }, { 0.1, 1 } } })

hl.animation({ leaf = 'global', enabled = true, speed = 10, bezier = 'default' })
hl.animation({ leaf = 'border', enabled = true, speed = 5.39, bezier = 'easeOutQuint' })
hl.animation({ leaf = 'windows', enabled = true, speed = 4.79, bezier = 'easeOutQuint' })
hl.animation({
  leaf = 'windowsIn',
  enabled = true,
  speed = 4.1,
  bezier = 'easeOutQuint',
  style = 'popin 87%',
})
hl.animation({
  leaf = 'windowsOut',
  enabled = true,
  speed = 1.49,
  bezier = 'linear',
  style = 'popin 87%',
})
hl.animation({ leaf = 'fadeIn', enabled = true, speed = 1.73, bezier = 'almostLinear' })
hl.animation({ leaf = 'fadeOut', enabled = true, speed = 1.46, bezier = 'almostLinear' })
hl.animation({ leaf = 'fade', enabled = true, speed = 3.03, bezier = 'quick' })
hl.animation({ leaf = 'layers', enabled = true, speed = 3.81, bezier = 'easeOutQuint' })
hl.animation({
  leaf = 'layersIn',
  enabled = true,
  speed = 4,
  bezier = 'easeOutQuint',
  style = 'fade',
})
hl.animation({ leaf = 'layersOut', enabled = true, speed = 1.5, bezier = 'linear', style = 'fade' })
hl.animation({ leaf = 'fadeLayersIn', enabled = true, speed = 1.79, bezier = 'almostLinear' })
hl.animation({ leaf = 'fadeLayersOut', enabled = true, speed = 1.39, bezier = 'almostLinear' })
hl.animation({
  leaf = 'workspaces',
  enabled = true,
  speed = 1.94,
  bezier = 'almostLinear',
  style = 'fade',
})
hl.animation({
  leaf = 'workspacesIn',
  enabled = true,
  speed = 1.21,
  bezier = 'almostLinear',
  style = 'fade',
})
hl.animation({
  leaf = 'workspacesOut',
  enabled = true,
  speed = 1.94,
  bezier = 'almostLinear',
  style = 'fade',
})

-- "Smart gaps" / "No gaps when only"
-- hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
-- hl.workspace_rule({ workspace = "f[1]", gaps_out = 0, gaps_in = 0 })
-- hl.window_rule({
--     match = { float = false, workspace = "w[tv1]" },
--     border_size = 0,
--     rounding = 0,
-- })
-- hl.window_rule({
--     match = { float = false, workspace = "f[1]" },
--     border_size = 0,
--     rounding = 0,
-- })

hl.config({
  master = {
    new_status = 'master',
  },

  misc = {
    force_default_wallpaper = -1,
    disable_hyprland_logo = true,
    disable_splash_rendering = true,
  },

  xwayland = {
    -- enabled = false,
    use_nearest_neighbor = false,
    force_zero_scaling = true,
  },
})

-------------
--- INPUT ---
-------------

hl.config({
  input = {
    kb_layout = 'custom',
    -- kb_variant = "",
    -- kb_model = "",
    -- kb_options = "",
    -- kb_rules = "",

    follow_mouse = 1,
    focus_on_close = 1,
    sensitivity = 0,
    natural_scroll = true,
    accel_profile = 'flat',
    scroll_factor = 0.333,
    emulate_discrete_scroll = 0,
  },
})

-- Example per-device config.
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/
hl.device({
  name = 'epic-mouse-v1',
  sensitivity = -0.5,
})

-------------------
--- KEYBINDINGS ---
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Binds/
local hyper = 'MOD3'
local super = 'MOD4'
local ctrl = 'CTRL'
local alt = 'ALT'
local shift = 'SHIFT'
local main_mod = hyper

-- Drag / resize des fenêtres avec la souris.
hl.bind(super .. ' + mouse:272', hl.dsp.window.drag(), { mouse = true })
hl.bind(super .. ' + mouse:273', hl.dsp.window.resize(), { mouse = true })

hl.bind(main_mod .. ' + Return', hl.dsp.exec_cmd('kitty'))
hl.bind(main_mod .. ' + Q', hl.dsp.window.close())
hl.bind(main_mod .. ' + ' .. shift .. ' + X', hl.dsp.exec_cmd('$DOTFILES/scripts/logout.sh'))
hl.bind(main_mod .. ' + ' .. shift .. ' + L', hl.dsp.exec_cmd('hyprlock'))

hl.bind(main_mod .. ' + E', hl.dsp.exec_cmd('/usr/bin/dolphin'))
hl.bind(main_mod .. ' + V', hl.dsp.window.float({ action = 'toggle' }))
-- hl.bind(main_mod .. " + R", hl.dsp.exec_cmd(menu))
-- hl.bind(main_mod .. " + P", hl.dsp.window.pseudo({ action = "toggle" }))
-- hl.bind(main_mod .. " + J", hl.dsp.layout("togglesplit"))
hl.bind(main_mod .. ' + F', hl.dsp.window.fullscreen({ action = 'toggle' }))
hl.bind(main_mod .. ' + R', hl.dsp.exec_cmd('$DOTFILES/scripts/reload.sh'))

hl.bind(
  super .. ' + space',
  hl.dsp.exec_cmd('/usr/bin/rofi -config $DOTFILES/rofi/rofi.rasi -show drun run')
)

hl.bind(main_mod .. ' + B', hl.dsp.exec_cmd('/usr/bin/gtk-launch brave-browser.desktop'))
hl.bind(main_mod .. ' + N', hl.dsp.exec_cmd('/usr/bin/gtk-launch obsidian.desktop'))

hl.bind(
  main_mod .. ' + ' .. ctrl .. ' + space',
  hl.dsp.exec_cmd(
    [=[/usr/bin/kitty --app-id e2696752-512f-11f0-ae75-ab75b60c01aa nvim "$(find ~ -maxdepth 1 -mindepth 1 ! -iname '.*' -type d | sort | rofi -p "play" -dmenu -i -l 10 -config $DOTFILES/rofi/mplayer.rasi)"]=]
  )
)

-- mplayer
hl.bind(main_mod .. ' + ' .. alt .. ' + space', hl.dsp.exec_cmd('mpc toggle'))
hl.bind(main_mod .. ' + ' .. alt .. ' + L', hl.dsp.exec_cmd('mpc next'))
hl.bind(main_mod .. ' + ' .. alt .. ' + H', hl.dsp.exec_cmd('mpc prev'))
hl.bind(
  main_mod .. ' + ' .. alt .. ' + ' .. shift .. ' + L',
  hl.dsp.exec_cmd('mpc seekthrough +10')
)
hl.bind(
  main_mod .. ' + ' .. alt .. ' + ' .. shift .. ' + H',
  hl.dsp.exec_cmd('mpc seekthrough -10')
)
hl.bind(
  main_mod .. ' + ' .. alt .. ' + ' .. shift .. ' + K',
  hl.dsp.exec_cmd('mpc seekthrough +20')
)
hl.bind(
  main_mod .. ' + ' .. alt .. ' + ' .. shift .. ' + J',
  hl.dsp.exec_cmd('mpc seekthrough -20')
)
hl.bind(main_mod .. ' + ' .. alt .. ' + K', hl.dsp.exec_cmd('mpc volume +5'))
hl.bind(main_mod .. ' + ' .. alt .. ' + J', hl.dsp.exec_cmd('mpc volume -5'))
hl.bind(main_mod .. ' + ' .. alt .. ' + R', hl.dsp.exec_cmd('mpc repeat'))

hl.bind(
  main_mod .. ' + ' .. ctrl .. ' + ' .. super .. ' + R',
  hl.dsp.exec_cmd('/usr/bin/kitty --app-id e2696752-512f-11f0-ae75-ab75b60c01aa /usr/bin/rmpc')
)

hl.bind(
  main_mod .. ' + ' .. super .. ' + ' .. shift .. ' + space',
  hl.dsp.exec_cmd([=[/usr/bin/zsh -c -i "$DOTFILES/scripts/mplayer-play-override-dir.sh music"]=])
)
hl.bind(
  main_mod .. ' + ' .. super .. ' + space',
  hl.dsp.exec_cmd(
    [=[/usr/bin/zsh -c -i "$DOTFILES/scripts/mplayer-play-override-dir.sh music.inbox"]=]
  )
)
hl.bind(
  main_mod .. ' + ' .. super .. ' + ' .. ctrl .. ' + space',
  hl.dsp.exec_cmd([=[/usr/bin/zsh -c -i "$DOTFILES/scripts/mplayer-play-override-playlists.sh"]=])
)
hl.bind(
  main_mod .. ' + ' .. super .. ' + ' .. shift .. ' + J',
  hl.dsp.exec_cmd([=[/usr/bin/zsh -c -i "$DOTFILES/scripts/mplayer-save-state.sh"]=])
)
hl.bind(
  main_mod .. ' + ' .. super .. ' + ' .. shift .. ' + K',
  hl.dsp.exec_cmd([=[/usr/bin/zsh -c -i "$DOTFILES/scripts/mplayer-load-state.sh"]=])
)
hl.bind(
  main_mod .. ' + ' .. ctrl .. ' + L',
  hl.dsp.exec_cmd([=[/usr/bin/zsh -c -i "$DOTFILES/scripts/mplayer-play-fanfare.sh"]=])
)

hl.bind(
  main_mod .. ' + ' .. super .. ' + M',
  hl.dsp.exec_cmd([=[/usr/bin/zsh -c -i "$DOTFILES/scripts/mplayer-move-to-lib.sh"]=])
)
hl.bind(
  main_mod .. ' + ' .. super .. ' + ' .. shift .. ' + M',
  hl.dsp.exec_cmd([=[/usr/bin/zsh -c -i "$DOTFILES/scripts/mplayer-remove-track.sh music.inbox"]=])
)
hl.bind(
  main_mod .. ' + ' .. ctrl .. ' + ' .. shift .. ' + M',
  hl.dsp.exec_cmd([=[/usr/bin/zsh -c -i "$DOTFILES/scripts/mplayer-remove-track.sh playlists"]=])
)

hl.bind(
  ctrl .. ' + ' .. alt .. ' + ' .. super .. ' + R',
  hl.dsp.exec_cmd("/bin/sh -c '/home/yul/dev/personal/dotfiles/remaps/wayland.setup.monitor.sh'")
)

hl.bind(
  main_mod .. ' + ' .. alt .. ' + ' .. super .. ' + P',
  hl.dsp.exec_cmd([=[/usr/bin/zsh -c -i "$DOTFILES/scripts/mplayer-playlist-edit.sh"]=])
)

hl.bind(
  main_mod .. ' + ' .. shift .. ' + P',
  hl.dsp.exec_cmd(
    [=[hyprshot -m region --output-folder="$HOME/Pictures" --filename="$(date +"%Y-%m-%d_%H%M%S").png"]=]
  )
)
hl.bind(
  main_mod .. ' + P',
  hl.dsp.exec_cmd(
    [=[hyprshot -m output --output-folder="$HOME/Pictures" --filename="$(date +"%Y-%m-%d_%H%M%S").png"]=]
  )
)

hl.bind(
  main_mod .. ' + ' .. super .. ' + C',
  hl.dsp.exec_cmd("bluetoothctl connect '20:18:5B:15:68:AD'")
)
hl.bind(
  main_mod .. ' + ' .. super .. ' + D',
  hl.dsp.exec_cmd("bluetoothctl disconnect '20:18:5B:15:68:AD'")
)

hl.bind(
  main_mod .. ' + ' .. ctrl .. ' + K',
  hl.dsp.exec_cmd("/usr/bin/mosquitto_pub -t desk -q 1 -h '10.0.0.4' -p 1883 -m light_updated")
)

-- Move focus with mainMod + H/J/K/L.
hl.bind(main_mod .. ' + H', hl.dsp.focus({ direction = 'left' }))
hl.bind(main_mod .. ' + L', hl.dsp.focus({ direction = 'right' }))
hl.bind(main_mod .. ' + K', hl.dsp.focus({ direction = 'up' }))
hl.bind(main_mod .. ' + J', hl.dsp.focus({ direction = 'down' }))

-- Switch workspaces, or move the active window, with mainMod + [0-9].
for workspace = 1, 10 do
  local key = workspace % 10
  hl.bind(main_mod .. ' + ' .. key, hl.dsp.focus({ workspace = workspace }))
  hl.bind(main_mod .. ' + ' .. shift .. ' + ' .. key, hl.dsp.window.move({ workspace = workspace }))
end

------------------------------
--- WINDOWS AND WORKSPACES ---
------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- See https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Ignore maximize requests from apps.
-- hl.window_rule({ match = { class = ".*" }, suppress_event = "maximize" })

-- Fix some dragging issues with XWayland.
-- hl.window_rule({
--     match = {
--         class = "^$",
--         title = "^$",
--         xwayland = true,
--         float = true,
--         fullscreen = false,
--         pin = false,
--     },
--     no_focus = true,
-- })

hl.window_rule({ match = { class = '^(kitty)$' }, workspace = '1 silent' })
hl.window_rule({ match = { class = 'brave-browser' }, workspace = '2 silent' })
hl.window_rule({ match = { class = 'obsidian' }, workspace = '3 silent' })
hl.window_rule({ match = { class = 'org.getmonero.monero-wallet-gui' }, workspace = '4 silent' })

hl.window_rule({ match = { class = '^(STM32CubeIDE)$' }, workspace = '4 silent' })
hl.window_rule({ match = { class = '^(STM32CubeIDE)$' }, float = true })
hl.window_rule({
  match = {
    class = '^(STM32CubeIDE)$',
    initial_title = '^(workspace_1.19.0 - STM32CubeIDE)$',
  },
  move = { 1, 1 },
})
hl.window_rule({
  match = {
    class = '^(STM32CubeIDE)$',
    initial_title = '^(workspace_1.19.0 - STM32CubeIDE)$',
  },
  size = { 1918, 1048 },
})
hl.window_rule({
  match = { class = '^(STM32CubeIDE)$', title = '^(Properties for .*)$' },
  move = { 295, 134 },
})
hl.window_rule({
  match = { class = '^(STM32CubeIDE)$', title = '^(Properties for .*)$' },
  size = { 1360, 823 },
})
hl.window_rule({
  match = { class = '^(STM32CubeIDE)$', title = '^(Run Configurations)$' },
  move = { 332, 183 },
})
hl.window_rule({
  match = { class = '^(STM32CubeIDE)$', title = '^(Run Configurations)$' },
  size = { 1185, 763 },
})

-- Window 5598f91d8100 -> workspace_1.19.0 - Device Configuration Tool - STM32CubeIDE:
--     mapped: 1
--     hidden: 0
--     at: 198,151
--     size: 1050,768
--     workspace: 4 (4)
--     floating: 1
--     pseudo: 0
--     monitor: 1
--     class: STM32CubeIDE
--     title: workspace_1.19.0 - Device Configuration Tool - STM32CubeIDE
--     initialClass: STM32CubeIDE
--     initialTitle: workspace_1.19.0 - STM32CubeIDE
--     pid: 421268
--     xwayland: 1
--     pinned: 0
--     fullscreen: 0
--     fullscreenClient: 0
--     grouped: 0
--     tags:
--     swallowing: 0
--     focusHistoryID: 1
--     inhibitingIdle: 0
--     xdgTag:
--     xdgDescription:

hl.window_rule({ match = { class = 'discord' }, workspace = '5 silent' })
hl.window_rule({ match = { class = 'vesktop' }, workspace = '5 silent' })

hl.window_rule({ match = { class = '^(kicad)$' }, workspace = '6 silent', float = true })
hl.window_rule({
  match = { class = '^(kicad)$', initial_title = '^(PCB Editor)$' },
  move = { 1, 1 },
})
hl.window_rule({
  match = { class = '^(kicad)$', initial_title = '^(PCB Editor)$' },
  size = { 1918, 1048 },
})

hl.window_rule({ match = { class = 'transmission-qt' }, workspace = '8 silent' })
hl.window_rule({ match = { class = 'org.keepassxc.KeePassXC' }, workspace = '9 silent' })
hl.window_rule({ match = { class = 'mpv' }, workspace = '10 silent' })
hl.window_rule({ match = { class = 'com.libretro.RetroArch' }, workspace = '10 silent' })

hl.window_rule({ match = { class = 'e2696752-512f-11f0-ae75-ab75b60c01aa' }, float = true })
hl.window_rule({
  match = { class = 'e2696752-512f-11f0-ae75-ab75b60c01aa' },
  size = { 1720, 967 },
})
hl.window_rule({
  match = { class = 'e2696752-512f-11f0-ae75-ab75b60c01aa' },
  move = { 100, 56 },
})

hl.window_rule({ match = { class = 'org.pulseaudio.pavucontrol' }, float = true })
hl.window_rule({ match = { class = 'org.kde.dolphin' }, float = true })
hl.window_rule({ match = { class = 'kdesystemsettings' }, float = true })
hl.window_rule({ match = { class = 'brave' }, float = true })
hl.window_rule({ match = { class = 'org.kde.kcalc' }, float = true })
hl.window_rule({ match = { class = 'xdg-desktop-portal-gtk' }, float = true })
hl.window_rule({ match = { class = 'com-st-stlinkupgrade-app-MainApp' }, float = true })

hl.window_rule({
  match = { class = '^(md.obsidian.Obsidian)$', title = '^(Settings - .*)$' },
  float = true,
  size = { 1185, 763 },
})
hl.window_rule({
  match = { class = '^(md.obsidian.Obsidian)$', title = '^(Community plugins - .*)$' },
  float = true,
  size = { 1185, 763 },
})
