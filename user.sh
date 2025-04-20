#!/bin/bash

ln -sf /usr/share/zoneinfo/Europe/Moscow /etc/localtime
hwclock --systohc

echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
echo "ru_RU.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen

echo LANG=ru_RU.UTF-8 > /etc/locale.conf

read -p "Enter HOSTNAME: " hostname
echo $hostname >> /etc/hostname
echo "127.0.0.1	localhost" >> /etc/hosts
echo "::1 	localhost" >> /etc/hosts
echo "127.0.1.1 $hostname.localdomain	$hostname" >> /etc/hosts

echo " Enter ROOT password: "
passwd
echo '[multilib]' >> /etc/pacman.conf
echo 'Include = /etc/pacman.d/mirrorlist' >> /etc/pacman.conf
sed -i '/DisableSandbox/a DisableDownloadTimeout' /etc/pacman.conf

pacman -Syy
pacman -S grub efibootmgr networkmanager sudo xdg-user-dirs ntfs-3g gvfs-mtp git base-devel bluez bluez-utils nvidia nvidia-utils os-prober

grub-install
echo "GRUB_DISABLE_OS_PROBER=false" >> /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager
systemctl enable bluetooth
systemctl enable fstrim.timer

EDITOR=nano
read -p "Enter USERNAME: " username
useradd -mG wheel $username
echo " Enter USER password: "
passwd $username
echo '%wheel ALL=(ALL) ALL' >> /etc/sudoers

printf "\e[1;32mInstall competed! ('umount -a' and 'reboot'.)\e[0m"
