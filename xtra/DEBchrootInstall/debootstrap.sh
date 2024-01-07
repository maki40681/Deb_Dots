#!/bin/sh
# https://help.ubuntu.com/lts/installation-guide/powerpc/apds04.html

printf "deb http://mirror.i3d.net/debian testing main contrib non-free"> /etc/apt/sources.list

printf "APT::Install-Recommends \"false\";
APT::Install-Suggests \"false\";
APT::Get::Purge \"true\";
APT::Get::AutomaticRemove \"true\";" > /etc/apt/apt.conf

apt update -y
apt install $(./pkgs) -y

locale-gen en_US.UTF-8
dpkg-reconfigure locales

printf "0.0 0 0.0
0
UTC" > /etc/adjtime
dpkg-reconfigure tzdata

printf "debian" > /etc/hostname
sed -i '1s/$/ debian/' /etc/hosts

/usr/sbin/e2label /dev/sda2 debian
printf "
menuentry \"Debian\" {
        icon     /EFI/refind/icons/os_debian.png
	volume	 \"debian\"
        loader   /vmlinuz
        initrd   /initrd.img
        options  \"root=PARTUUID=$(/sbin/blkid -s PARTUUID -o value /dev/sda2) rw quiet rootfstype=ext4 add_efi_memmap loglevel=0 udev.log_level=0 rd.systemd.show_status=false\"
}" >> /boot/efi/EFI/refind/refind.conf
umount -R /boot/efi

printf "\nROOT Password\n"
passwd

useradd -m -G sudo,audio,video -s /usr/bin/zsh maki40681
printf "\nUSER Password\n"
passwd maki40681

apt clean
