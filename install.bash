#Connect to wifi
wifi-menu

# list current partitions
lsblk

# Create drive partitions
cgdisk /dev/sda 

# format hard drive
mkfs.ext4 /dev/sda1

# format swap
mkswap /dev/sda3
swapon /dev/sda3

# Mount partition, ie. sda1
mount /dev/sda1

# choose mirror
nano /etc/pacman.d/mirrorlist

# install base packages
pacstrap /mnt base base-devl

# configure filesystem with fstab
genfstab -U -p /mnt >> /mnt/etc/fstab

# make sure fstab entry looks good
cat /mnt/etc/fstab

# chroot into system to configure it
arch-chroot /mnt

# set hostname
echo computer_name > /etc/hostname

# uncomment locales in /etc/locale.gen
nano /etc/locale.gen 

# generate locales
locale-gen

# set locale preferences in /etc/locale.conf and possibly $HOME/.config/locale.conf
echo LANG=en_US.UTF-8 > /etc/locale.conf
export LANG=en_US.UTF-8

# set the time zone
ln -sf /usr/share/zoneinfo/Canada/Pacific /etc/localtime

# configure hardware clock
hwclock --systohc --utc

# set root password
passwd

# add user
useradd -m -g users -G wheel,storage,power -s /bin/bash jay
passwd jay

# visudo new user
EDITOR=nano visudo

# install bash-completion
pacman -S bash-completion

# install bootloader
pacman -S grub
grub-install --target=i386-pc --recheck /dev/sda

# os-prober checks for installed operating systems
pacman -S os-prober

# make grub aware of other distros
grub-mkconfig -o /boot/grub/grub.cfg

# install dialog and wpa_actiond
pacman -S dialog wpa_actiond

# use systemd to configure netowrk to start at system boot
# first, check interface_name with ip link
ip link 
systemctl enable netctl-auto@<interface_name>.service 

# install lightdm and greeter
pacman -S lightdm lightdm-gtk-greeter

# install openbox 
pacman -S openbox obconf obmenu

# install menumaker
pacman -S menumaker

# generate menu
pacman -S mmaker -v OpenBox3

# install screenfetch
pacman -S screenfetch

# add screenfetch to end of .bashrc
vim ~/.bashrc
