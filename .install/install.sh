#!/bin/bash
source .install/colors.sh
source .install/library.sh
clear

echo "Josh Dotfiles"
echo "Based on work from Stephan Raabe 2024 (https://gitlab.com/stephan-raabe/dotfiles)"
echo ""

if [ -d ~/.dotfiles ] ;then
    echo "This script will guide you through the update process dotfiles"
    echo "This script will guide you through the installation process of dotfiles."
fi
echo ""

source .install/required.sh
source .install/confirm-start.sh
source .install/yay.sh
source .install/backup.sh
source .install/preparation.sh
source .install/profile.sh
source .install/installer.sh
source .install/general.sh
source .install/general-packages.sh
source .install/install-packages.sh

if [[ $profile == *"Hyprland"* ]]; then
    source .install/hyprland.sh
    source .install/hyprland-packages.sh
    source .install/install-packages.sh
fi
source .install/pywal.sh
source .install/wallpaper.sh
source .install/displaymanager.sh
source .install/issue.sh
source .install/restore.sh
source .install/vm.sh
source .install/keyboard.sh
source .install/hook.sh
source .install/copy.sh
source .install/config-folder.sh
source .install/init-pywal.sh
if [[ $profile == *"Hyprland"* ]]; then
    source .install/hyprland-dotfiles.sh
fi
if [[ $profile == *"Qtile"* ]]; then
    source .install/qtile-dotfiles.sh
fi
source .install/gtk.sh
source .install/bashrc.sh
source .install/monitor.sh
source .install/cleanup.sh
source .install/done.sh
