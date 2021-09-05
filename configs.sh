#
# For use with https://github.com/pop-os/shell/
#
#   which is trying to be i3, but on top of gnome
#
# Use these extensions:
#  https://extensions.gnome.org/extension/3851/workspaces-bar/
#  https://extensions.gnome.org/extension/758/no-workspace-switcher-popup/

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

# Launchers
gsettings set org.gnome.settings-daemon.plugins.media-keys control-center "['<Super>backslash']"
gsettings set org.gnome.settings-daemon.plugins.media-keys home "['<Super>minus']"

# Screenshots, disabled for the most part, use flameshot instead
gsettings set org.gnome.settings-daemon.plugins.media-keys window-screenshot-clip []
gsettings set org.gnome.settings-daemon.plugins.media-keys area-screenshot-clip []
gsettings set org.gnome.settings-daemon.plugins.media-keys window-screenshot []
gsettings set org.gnome.settings-daemon.plugins.media-keys area-screenshot []
gsettings set org.gnome.settings-daemon.plugins.media-keys screenshot []
gsettings set org.gnome.settings-daemon.plugins.media-keys screenshot-clip "['Print']"
# Flameshot
dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/command "'flameshot gui'"
dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/binding "'<Shift><Super>s'"
dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/name "'Interactive Screenshot'"


# Tile Movement -- does this work?
dconf write '/org/gnome/shell/extensions/pop-shell/tile-move-left' "['<Super><Shift>h']"
dconf write '/org/gnome/shell/extensions/pop-shell/tile-move-right' "['<Super><Shift>n']"
dconf write '/org/gnome/shell/extensions/pop-shell/tile-move-up' "['<Super><Shift>c']"
dconf write '/org/gnome/shell/extensions/pop-shell/tile-move-down' "['<Super><Shift>t']"


# Hide Icons -- can't have a messy desktop if there are no visible icons!
# (this also fixes the remaining empty tile in pop-shell)
gnome-extensions disable ding@rastersoft.com
