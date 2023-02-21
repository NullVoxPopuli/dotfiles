#
# For use with https://github.com/pop-os/shell/
#
#   which is trying to be i3, but on top of gnome
#
# Use these extensions:
#  https://extensions.gnome.org/extension/3851/workspaces-bar/
#  https://extensions.gnome.org/extension/758/no-workspace-switcher-popup/
#  https://extensions.gnome.org/extension/808/hide-workspace-thumbnails/
#  https://extensions.gnome.org/extension/805/hide-dash/
#
# App Launcher:
#  https://albertlauncher.github.io


# To debug:
# gsettings list-recursively | grep -F "<Super>" # all shortcuts that contain Super
# gsettings list-recursively | grep -F "'<Super>7'" # all Super7 shortcuts


# Use fixed number of workspaces to simulate i3
gsettings set org.gnome.mutter dynamic-workspaces false
gsettings set org.gnome.desktop.wm.preferences num-workspaces 10

# Dock-related hotkeys suck
gsettings set org.gnome.shell.keybindings switch-to-application-1  []
gsettings set org.gnome.shell.keybindings switch-to-application-2  []
gsettings set org.gnome.shell.keybindings switch-to-application-3  []
gsettings set org.gnome.shell.keybindings switch-to-application-4  []
gsettings set org.gnome.shell.keybindings switch-to-application-5  []
gsettings set org.gnome.shell.keybindings switch-to-application-6  []
gsettings set org.gnome.shell.keybindings switch-to-application-7  []
gsettings set org.gnome.shell.keybindings switch-to-application-8  []
gsettings set org.gnome.shell.keybindings switch-to-application-9  []

# <Sumer> + <Workspace #>
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-1  "['<Super>1']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-2  "['<Super>2']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-3  "['<Super>3']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-4  "['<Super>4']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-5  "['<Super>5']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-6  "['<Super>6']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-7  "['<Super>7']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-8  "['<Super>8']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-9  "['<Super>9']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-10 "['<Super>0']"

# Move a window to a particular workspace
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-1  "['<Super><Shift>1']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-2  "['<Super><Shift>2']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-3  "['<Super><Shift>3']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-4  "['<Super><Shift>4']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-5  "['<Super><Shift>5']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-6  "['<Super><Shift>6']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-7  "['<Super><Shift>7']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-8  "['<Super><Shift>8']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-9  "['<Super><Shift>9']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-10 "['<Super><Shift>0']"

# Disable potentially problematic / accidental keybindings
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-last []
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-up []
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-down []
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-left []
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-right []
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-up []
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-down []
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-left []
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-right []

# Disable actually problematic keybindings
gsettings set org.gnome.desktop.wm.keybindings minimize []
gsettings set org.gnome.desktop.wm.keybindings show-desktop []

# Launchers
gsettings set org.gnome.mutter overlay-key ""
gsettings set org.gnome.settings-daemon.plugins.media-keys control-center "['<Super>backslash']"
gsettings set org.gnome.settings-daemon.plugins.media-keys home "['<Super>minus']"

keybindingKey=0
function keybinding() {
  keybindingKey=$((keybindingKey+1))

  local name=$1
  local command=$2
  local binding=$3
  local dconfPath="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom$keybindingKey/"
  local gsettingsPath="org.gnome.settings-daemon.plugins.media-keys.custom-keybinding"
  local fullPath="${gsettingsPath}:${dconfPath}"

  gsettings set "${gsettingsPath}:${dconfPath}" name "'$name'"
  gsettings set "${gsettingsPath}:${dconfPath}" binding "'$binding'"
  gsettings set "${gsettingsPath}:${dconfPath}" command "'$command'"

}

keybinding 'App Launcher' 'albert toggle' '<Super>d'
keybinding 'Interactive Screenshot' 'flameshot gui' '<Shift><Super>s'

# pop-shell settings
#
# schema: https://github.com/pop-os/shell/blob/master/schemas/org.gnome.shell.extensions.pop-shell.gschema.xml
dconf write '/org/gnome/shell/extensions/pop-shell/active-hint' "true"
dconf write '/org/gnome/shell/extensions/pop-shell/hint-color-rgba' "'rgba(158,0,255,0.7)'"
dconf write '/org/gnome/shell/extensions/pop-shell/smart-gaps' "true"
dconf write '/org/gnome/shell/extensions/pop-shell/snap-to-grid' "true"
dconf write '/org/gnome/shell/extensions/pop-shell/gap-inner' 0
dconf write '/org/gnome/shell/extensions/pop-shell/gap-outer' 0
dconf write '/org/gnome/shell/extensions/pop-shell/toggle-floating' "['<Super>Space']"

# Enter Edit mode
# o - toggle orientation (default)
dconf write '/org/gnome/shell/extensions/pop-shell/tile-enter' "['<Super>u']"
# Focus Movement
dconf write '/org/gnome/shell/extensions/pop-shell/focus-left' "['<Super>h']"
dconf write '/org/gnome/shell/extensions/pop-shell/focus-right' "['<Super>n']"
dconf write '/org/gnome/shell/extensions/pop-shell/focus-up' "['<Super>c']"
dconf write '/org/gnome/shell/extensions/pop-shell/focus-down' "['<Super>t']"
# Tile Movement -- requires "edit mode"
dconf write '/org/gnome/shell/extensions/pop-shell/tile-move-left' "['<Super>h']"
dconf write '/org/gnome/shell/extensions/pop-shell/tile-move-right' "['<Super>n']"
dconf write '/org/gnome/shell/extensions/pop-shell/tile-move-up' "['<Super>c']"
dconf write '/org/gnome/shell/extensions/pop-shell/tile-move-down' "['<Super>t']"
dconf write '/org/gnome/shell/extensions/pop-shell/tile-swap-left' "['<Super><Shift>h']"
dconf write '/org/gnome/shell/extensions/pop-shell/tile-swap-right' "['<Super><Shift>n']"
dconf write '/org/gnome/shell/extensions/pop-shell/tile-swap-up' "['<Super><Shift>c']"
dconf write '/org/gnome/shell/extensions/pop-shell/tile-swap-down' "['<Super><Shift>t']"
# Tile Resizing -- requires "edit mode"
dconf write '/org/gnome/shell/extensions/pop-shell/tile-resize-left' "['h']"
dconf write '/org/gnome/shell/extensions/pop-shell/tile-resize-right' "['n']"
dconf write '/org/gnome/shell/extensions/pop-shell/tile-resize-up' "['c']"
dconf write '/org/gnome/shell/extensions/pop-shell/tile-resize-down' "['t']"

# Hide Icons -- can't have a messy desktop if there are no visible icons!
# (this also fixes the remaining empty tile in pop-shell)
gnome-extensions disable ding@rastersoft.com


# Behaviors
gsettings set org.gnome.desktop.input-sources xkb-options "['ctrl:nocaps']"
gsettings set org.gnome.Terminal.Legacy.Settings headerbar false
