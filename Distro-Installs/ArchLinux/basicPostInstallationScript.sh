#!/bin/sh

if [ "$(id -u)" = "0" ]; then
  echo "You can't execute this script as root (or with sudo)! Please run it as user"
  exit 1
fi

sudo pacman -Syu
sudo pacman -S --needed vim neovim # Install text editors
sudo pacman -S --needed networkmanager nm-connection-editor network-manager-applet ppp # Install network management
sudo pacman -S --needed base-devel git # Install yay requirements
sudo pacman -S --needed flatpak fastfetch alacritty duf htop samba curl firefox firefox-developer-edition thunderbird gnupg # Misc stuff

echo "Start installation of yay..."
# Installation of yay
cd ~
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si  # Follow instructions on screen
yay --version # Check installation of yay
echo "yay was successfully installed..." && echo ""

yay -Syu
yay -S --needed mkinitcpio-numlock
echo "Don't forget to add ´numlock´ in ´/etc/mkinitcpio.conf´ as described in ´https://wiki.archlinux.org/title/Activating_numlock_on_bootup´" && echo ""

echo "Start installation of Hyprland"
# Hyprland installation
sudo pacman -S --needed hyprland uwsm rofi dolphin archlinux-xdg-menu
XDG_MENU_PREFIX=arch- kbuildsycoca6 # Make dolphin recognize xdg-mime default applications
sudo pacman -S --needed gtk4 rust greetd # Installs a login manager (greetd)
sudo pacman -S --needed slurp grim wl-clipboard
yay -S greetd-regreet-git # ReGreet is a greetd Greeter
yay -S mullvad-vpn mullvad-tray

rm ~/.config/hypr/hyprland.conf
curl "https://raw.githubusercontent.com/Haerbernd/Haerbernd/refs/heads/main/Distro-Installs/ArchLinux/dotfiles/configs/hypr/hyprland.conf" -o "~/.config/hypr/hyprland.conf # Download Hyprland config"
curl "https://raw.githubusercontent.com/Haerbernd/Haerbernd/refs/heads/main/Distro-Installs/ArchLinux/dotfiles/localbin/make-screenshot.sh" -o "~/.local/bin/make-screenshot.sh" && chmod +x "~/.local/bin/make-screenshot.sh"

# Needs to be appended to the ~/.bashrc for uwsm to start Hyprland on boot/login
cat >> ~/.bashrc << 'EOF'

if uwsm check may-start; then
    exec uwsm start hyprland.desktop
fi

EOF

sudo pacman -S --needed mako pipewire wireplumber qt5-wayland qt6-wayland xdg-desktop-portal-hyprland xdg-desktop-portal-gtk hyprpolkitagent
curl "https://raw.githubusercontent.com/Haerbernd/Haerbernd/refs/heads/main/Distro-Installs/ArchLinux/dotfiles/configs/hypr/xdph.conf" -o "~/.config/hypr/xdph.conf"
systemctl --user enable --now hyprpolkitagent.service
echo "Hyprland was successfully installed..." && echo ""

echo "Start installing further systems of the Hypr-Ecosystem"
curl "https://raw.githubusercontent.com/Haerbernd/Haerbernd/refs/heads/main/Distro-Installs/ArchLinux/hyprEcosystemSetup.sh" -o "~/hyprEcosystemSetup.sh"
~./hyprEcosystemSetup.sh
echo "Hypr-Ecosystem was successfully installed..."
echo "Start removing installation script..."
rm hyprEcosystemSetup.sh
echo "done..." && echo ""

# Start Installation of Development Environment
curl "" -o "~/prepareDevelopmentEnvironmentScript.sh" && chmod +x "~/prepareDevelopmentEnvironmentScript.sh"
~/prepareDevelopmentEnvironmentScript.sh
rm "~/prepareDevelopmentEnvironmentScript.sh"

