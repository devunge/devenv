#!/bin/bash

CHEATSHEET=$(cat << 'KEYS'
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    I3WM KEYBINDINGS CHEATSHEET
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📋 SISTEMA
  $mod+Return        → Terminal
  $mod+d             → App Launcher (Rofi)
  $mod+Shift+q       → Fechar janela
  $mod+Shift+r       → Reload i3 config
  $mod+Shift+e       → Exit i3

🪟 JANELAS
  $mod+h/j/k/l       → Focar janela (←↓↑→)
  $mod+Shift+h/j/k/l → Mover janela
  $mod+f             → Fullscreen
  $mod+Shift+space   → Toggle floating
  $mod+e             → Toggle split

📊 WORKSPACES
  $mod+1-9           → Ir para workspace
  $mod+Shift+1-9     → Mover para workspace

📸 SCREENSHOTS
  Print              → Tela inteira
  $mod+Print         → Área selecionada
  $mod+Shift+Print   → Janela ativa
  Ctrl+Print         → Para clipboard

🎥 GRAVAÇÃO
  $mod+Shift+r       → Toggle recording (tela)
  $mod+Shift+Ctrl+r  → Recording (área)

🎨 UTILITÁRIOS
  $mod+v             → Clipboard Manager
  $mod+Shift+c       → Color Picker
  $mod+k             → Esta cheatsheet

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
KEYS
)

# Mostrar com rofi
echo "$CHEATSHEET" | rofi -dmenu -i -p "Keybindings" \
  -theme-str 'window {width: 800px; height: 600px;}' \
  -theme-str 'listview {lines: 30;}'
