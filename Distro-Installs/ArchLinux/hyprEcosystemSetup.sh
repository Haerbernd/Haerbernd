#!/bin/sh

sudo pacman -S --needed hyprpanel hyprpaper hyprpicker hypridle hyprlock pambase hyprsysteminfo hyprutils

curl "https://raw.githubusercontent.com/Haerbernd/Haerbernd/refs/heads/main/Distro-Installs/ArchLinux/dotfiles/configs/hypr/hypridle.conf" -o "~/.config/hypr/hypridle.conf"
curl "https://raw.githubusercontent.com/Haerbernd/Haerbernd/refs/heads/main/Distro-Installs/ArchLinux/dotfiles/configs/hypr/hyprlock.conf" -o "~/.config/hypr/hyprlock.conf"

sudo systemctl --user enable --now hypridle.service
yay -Syu xwaylandvideobridge-git
