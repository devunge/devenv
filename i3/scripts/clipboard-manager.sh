#!/bin/bash

# Iniciar cliphist se não estiver rodando
if ! pgrep -x "wl-paste" > /dev/null; then
    wl-paste --watch cliphist store &
fi

# Mostrar menu de clipboard
cliphist list | rofi -dmenu -p "Clipboard" -i | cliphist decode | xclip -selection clipboard
