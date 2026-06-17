#!/bin/bash

dir="$HOME/.config/rofi/helper"

expr=$(run_input)

if [ -z "$expr" ]; then
  exit
else
  ans=$(echo "$expr" | bc)
  echo "$ans" | xclip -selection clipboard
  notify-send "$ans"
  notify-send "in clipboard"
fi
