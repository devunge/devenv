#!/bin/bash

echo "🚀 Instalando ambiente i3 para desenvolvimento..."

# Atualizar sistema
sudo pacman -Syu --noconfirm

# Compositor e notificações
sudo pacman -S --noconfirm picom dunst libnotify

# Fontes e temas
sudo pacman -S --noconfirm ttf-jetbrains-mono-nerd ttf-fira-code ttf-font-awesome noto-fonts noto-fonts-emoji
sudo pacman -S --noconfirm papirus-icon-theme arc-gtk-theme lxappearance

# Rofi e wallpaper
sudo pacman -S --noconfirm rofi feh nitrogen

# Terminal e shell
sudo pacman -S --noconfirm alacritty zsh starship

# Ferramentas dev
sudo pacman -S --noconfirm git github-cli neovim tmux
sudo pacman -S --noconfirm ranger lf fzf fd ripgrep bat exa

# Monitores sistema
sudo pacman -S --noconfirm htop btop neofetch

# Utilitários
sudo pacman -S --noconfirm flameshot peek copyq
sudo pacman -S --noconfirm brightnessctl playerctl pavucontrol

# Polybar (AUR)
yay -S --noconfirm polybar

echo "✅ Instalação concluída!"
echo "📝 Agora copie as configurações dos artifacts"
echo "🔄 Reinicie o i3 com Mod+Shift+r"
