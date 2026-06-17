#!/usr/bin/env sh

# notification service
dunst &

run() {
  if ! pgrep -f "$1" >/dev/null; then
    "$@" &
  fi
}

# polybar
run ~/.config/polybar/launch.sh

# picom
run picom --config ~/.config/picom/picom.conf &

# network manager applet
run nm-applet &
notify-send "Setup" "NetworkManagr On"

# volume handle
run volumeicon &

# bluetooth service
run blueman-applet &
notify-send "Setup" "BluetoothService On"

# power / batery manager
run xfce4-power-manager &
notify-send "Setup" "PowerManager On"
