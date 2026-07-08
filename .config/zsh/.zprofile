#=-[ENV VARS]-=#
export MOZ_WEBRENDER=1
export MOZ_ENABLE_WAYLAND=1
export MOZ_DISABLE_RDD_SANDBOX=1

export XDG_CACHE_HOME=$HOME/.cache
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state

export XINITRC=$XDG_CONFIG_HOME/X11/xinitrc
export XAUTHORITY=$XDG_RUNTIME_DIR/Xauthority

export TERMINFO=$XDG_DATA_HOME/terminfo
export LD_LIBRARY_PATH="$HOME"/.local/lib
export PATH=$HOME/.local/bin:/usr/sbin:$PATH

export EDITOR=nvim
export GTK_THEME=Adwaita-dark
export LIBVA_DRIVER_NAME=iHD
export QT_QPA_PLATFORMTHEME=qt5ct
export TMUX_TMPDIR=$XDG_STATE_HOME
export MANPAGER="nvim -c 'Man!' -o -"
export GTK2_RC_FILES=$XDG_CONFIG_HOME/gtk-2.0/gtkrc

if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
    #exec dbus-run-session dwl &> /tmp/dwl.log
    #exec ssh-agent startx "$XDG_CONFIG_HOME/X11/xinitrc" &> /tmp/dwm.log
    #exec dbus-run-session ssh-agent startx "$XDG_CONFIG_HOME/X11/xinitrc" &> /tmp/dwm.log
    exec start-hyprland &> /tmp/hypr.log
fi
