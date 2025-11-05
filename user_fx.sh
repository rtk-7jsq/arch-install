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
pacman -S grub networkmanager sudo xdg-user-dirs ntfs-3g gvfs-mtp git base-devel os-prober

grub-install --target=i386-pc /dev/sda
echo "GRUB_DISABLE_OS_PROBER=false" >> /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager

EDITOR=nano
read -p "Enter USERNAME: " username
useradd -mG wheel $username
echo " Enter USER password: "
passwd $username
echo '%wheel ALL=(ALL) ALL' >> /etc/sudoers

printf "\e[1;32mInstallation comlpeted! ('umount -a' and 'reboot'.)\e[0m"
