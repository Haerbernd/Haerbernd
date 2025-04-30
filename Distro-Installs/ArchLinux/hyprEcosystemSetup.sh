#!/bin/sh

sudo pacman -S --needed hyprpanel hyprpaper hyprpicker hypridle hyprlock

curl "" -o "~/.config/hypr/hypridle.conf"
curl "" -o "~/.config/hypr/hyprlock.conf"

sudo systemctl --user enable --now hypridle.service
