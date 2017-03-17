#!/bin/bash
#
##############################
#### Pre provisioning
#### Install Arch Linux
####
#### Enable EFI
#### * VirtualBox => Settings => System => Enable EFI (special OSes only)
####
#### Start Arch ~linux as VirtualBox guest OS
##############################
#
# timedatectl set-ntp true
#
# sgdisk -n 1::+512M /dev/sda
# sgdisk -t 1:EF00   /dev/sda
# sgdisk -n 2::      /dev/sda
#
# mkfs -t vfat -F32 /dev/sda1
# mkfs -t ext4      /dev/sda2
#
# mount /dev/sda2 /mnt
# mkdir /mnt/boot
# mount /dev/sda1 /mnt/boot
#
# vi /etc/pacman.d/mirrorlist => use jaist, tsukuba
# pacman -Syy
# pacstrap /mnt base base-devel
#
# genfstab -U /mnt >> /mnt/etc/fstab
#
# arch-chroot /mnt/ /bin/bash
#
# vi /etc/locale.gen => use en_US.UTF-8, ja_JP.UTF-8
# locate-gen
# echo LANG=en_US.UTF-8 > /etc/locale.conf
# export LANG=en_US.UTF-8
#
# ln -s /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
# hwclock --systohc --utc
#
# systemctl enable dhcpcd
#
# passwd
#
# pacman -S grub dosfstools efibootmgr
# grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=arch_grub --recheck
# grub-mkconfig -o /boot/grub/grub.cfg
# mkdir /boot/EFI/boot
# cp /boot/EFI/arch_grub/grubx64.efi  /boot/EFI/boot/bootx64.efi
#
# exit
# umount -R /mnt
# shutdown -h now
#
##############################
#### Remove Arch Linux iso
#### Start Arch Linux as VirtualBox guest OS
##############################
#
# useradd -m -G wheel -s /bin/bash foo
# passwd foo
# visudo => use %wheel ALL=(ALL) ALL
#
# vi /etc/pacman.conf =>
# [archlinuxfr]
# SigLevel = Never
# Server = http://repo.archlinux.fr/$arch
#
# sudo pacman --sync --refresh yaourt
#
# sudo pacman -S virtualbox-guest-utils => select 2 (virtualbox-guest-modules-arch)
# sudo systemctl enable vboxservice
# sudo shutdown -h now
#
##############################

pacman -S openssh
# for "Host-only", see https://wiki.archlinux.org/index.php/VirtualBox#Load_the_VirtualBox_kernel_modules
pacman -S net-tools
pacman -S mlocate
pacman -S tmux
pacman -S vim
pacman -S git
pacman -S tig
pacman -S the_silver_searcher
