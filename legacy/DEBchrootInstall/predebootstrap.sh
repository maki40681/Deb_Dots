#!/bin/sh

debootstrap --arch amd64 bullseye /mnt
genfstab -U /mnt >> /mnt/etc/fstab
mv debootstrap.sh pkgs /mnt
arch-chroot /mnt
