#!/bin/bash
#
##############################
#### Pre provisioning
#### Install Arch Linux
####
#### Enable EFI (and Nested Virtualization only VMware)
#### * VirtualBox
####   * Settings => System => Enable EFI (special OSes only)
#### * VMware
####   * `vim archlinux.vmx`, and add below lines
####     * firmware = "efi"
####     * vhv.enable = "TRUE"
####
#### Start Arch linux as guest OS
####
#### passwd
#### systemctl start sshd
#### ip a
####
#### Connect from iTerm2
##############################
#
# timedatectl set-ntp true
#
# sgdisk -n 1::+512M /dev/sda
# sgdisk -t 1:EF00   /dev/sda
# sgdisk -n 2::      /dev/sda
#
# mkfs.vfat -F32 /dev/sda1
# mkfs.btrfs     /dev/sda2
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
# locale-gen
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
#### Start Arch Linux as guest OS
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

# https://wiki.archlinuxjp.org/index.php/%E6%99%82%E5%88%BB
timedatectl set-timezone Asia/Tokyo

pacman --needed -S openssh

# https://github.com/rbenv/ruby-build/wiki
pacman --needed -S openssl
pacman --needed -S libyaml
pacman --needed -S libffi
pacman --needed -S zlib

pacman --needed -S bash-completion
pacman --needed -S gptfdisk
pacman --needed -S mlocate
pacman --needed -S tmux
pacman --needed -S git
pacman --needed -S tig
pacman --needed -S the_silver_searcher
pacman --needed -S strace
pacman --needed -S unzip
pacman --needed -S go
pacman --needed -S python
pacman --needed -S python-pip
pacman --needed -S python-editorconfig
pacman --needed -S vim
pacman --needed -S docker
# https://wiki.archlinuxjp.org/index.php/Docker
# tee /etc/modules-load.d/loop.conf <<< "loop"
# modprobe loop

updatedb
