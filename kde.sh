#!/bin/bash

sudo pacman -S plasma firefox obs-studio vlc ffmpeg kio-admin ncdu noto-fonts-cjk telegram-desktop dolphin konsole ffmpegthumbs grub-customizer spectacle htop evince libreoffice libreoffice-fresh-ru code kdeconnect ark easytag power-profiles-daemon kcalc openssh elisa gimp

sudo systemctl enable sddm

printf "\e[1;32mInstallation completed!\e[0m"

