#!/bin/sh

sudo pacman -S --needed hyprpanel hyprpaper hyprpicker hypridle hyprlock pambase hyprsysteminfo hyprutils

curl "" -o "~/.config/hypr/hypridle.conf"
curl "" -o "~/.config/hypr/hyprlock.conf"

sudo systemctl --user enable --now hypridle.service
yay -Syu xwaylandvideobridge-git
