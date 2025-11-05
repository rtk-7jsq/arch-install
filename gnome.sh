#!/bin/bash

sudo pacman -S gnome dconf-editor gnome-tweaks extension-manager firefox-developer-edition obs-studio vlc ffmpeg ncdu noto-fonts-cjk telegram-desktop htop libreoffice libreoffice-fresh-ru code easytag openssh gimp

sudo systemctl enable gdm

printf "\e[1;32mInstallation completed!\e[0m"

