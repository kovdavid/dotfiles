Thinkpad L14 Gen5 Ryzen 7 Pro 250

Based on https://www.dwarmstrong.org/archlinux-install/

# Boot from USB
- `rmmod pcspkr` - no beep
- `setfont ter-132b` - bigger font
- `ip link` - check WiFi card name
- Wifi
  - `iwctl`
  - `device list`
  - `station wlan0 scan`
  - `station wlan0 get-networks`
  - `station wlan0 connect HUAWEI-fFX7-5G`
- `timedatectl` - ensure system clock is synched
- ```bash
export DISK="/dev/nvme0n1"
export ESP_PART="1"
export ROOT_PART="2"
export ESP_DISK="${DISK}p${ESP_PART}"
export ROOT_DISK="${DISK}p${ROOT_PART}"
export ROOT_DEV="/dev/mapper/root"

# Wipe disk
wipefs -af $DISK && sgdisk --zap-all --clear $DISK
partprobe $DISK

# Partition disk
sgdisk -n "${ESP_PART}:1m:+4g" -t "${ESP_PART}:ef00" -c 0:esp $DISK
sgdisk -n "${ROOT_PART}:0:0" -t "${ROOT_PART}:8309" -c 0:root $DISK
partprobe $DISK && sgdisk -p $DISK

# Format
mkfs.fat -n ESP -F 32 $ESP_DISK
cryptsetup luksFormat -y --type luks2 $ROOT_DISK
cryptsetup open $ROOT_DISK root
mkfs.btrfs -L arch $ROOT_DEV
mount $ROOT_DEV /mnt

# Subvolumes
btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@home
btrfs subvolume create /mnt/@log
btrfs subvolume create /mnt/@tmp
btrfs subvolume create /mnt/@srv
btrfs subvolume create /mnt/@snapshots
btrfs subvolume create /mnt/@opt
btrfs subvolume create /mnt/@var_cache
btrfs subvolume create /mnt/@var_lib_docker
btrfs subvolume create /mnt/@var_lib_flatpak

export SUB_OPTS="noatime,compress=zstd:1,space_cache=v2"

umount /mnt

mount -o ${SUB_OPTS},subvol=@ $ROOT_DEV /mnt
mount --mkdir -o ${SUB_OPTS},subvol=@home $ROOT_DEV /mnt/home
mount --mkdir -o ${SUB_OPTS},subvol=@log $ROOT_DEV /mnt/var/log
mount --mkdir -o ${SUB_OPTS},subvol=@tmp $ROOT_DEV /mnt/var/tmp
mount --mkdir -o ${SUB_OPTS},subvol=@srv $ROOT_DEV /mnt/srv
mount --mkdir -o ${SUB_OPTS},subvol=@snapshots $ROOT_DEV /mnt/.snapshots
mount --mkdir -o ${SUB_OPTS},subvol=@opt $ROOT_DEV /mnt/opt
mount --mkdir -o ${SUB_OPTS},subvol=@var_cache $ROOT_DEV /mnt/var/cache
mount --mkdir -o ${SUB_OPTS},subvol=@var_lib_docker $ROOT_DEV /mnt/var/lib/docker
mount --mkdir -o ${SUB_OPTS},subvol=@var_lib_flatpak $ROOT_DEV /mnt/var/lib/flatpak

mount --mkdir $ESP_DISK /mnt/boot && df -h

cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
reflector --verbose --protocol https --latest 5 --sort rate --save /etc/pacman.d/mirrorlist
pacman -Syy

export UCODE="amd-ucode"
pacstrap -K /mnt base base-devel linux linux-firmware btrfs-progs cryptsetup efibootmgr limine man-db networkmanager openssh reflector sudo terminus-font $UCODE vim

genfstab -L /mnt >> /mnt/etc/fstab && cat /mnt/etc/fstab

arch-chroot /mnt /bin/bash

echo "zram" > /etc/modules-load.d/zram.conf

echo 'ACTION=="add", KERNEL=="zram0", ATTR{initstate}=="0", ATTR{comp_algorithm}="zstd", ATTR{disksize}="4G", TAG+="systemd"' > /etc/udev/rules.d/99-zram.rules

echo -e "/dev/zram0\tnone\tswap\tdefaults,discard,pri=100,x-systemd.makefs\t0 0" >> /etc/fstab

timedatectl set-timezone Europe/Bratislava
hwclock --systohc
timedatectl set-ntp true
timedatectl

vim /etc/local.gen
# uncomment:
# en_US.UTF-8 UTF-8
# sk_SK.UTF-8 UTF-8
# hu_HU.UTF-8 UTF-8

locale-gen

echo LANG=en_US.UTF-8 > /etc/locale.conf
echo LANGUAGE=en_US >> /etc/locale.conf
echo LC_ALL=C >> /etc/locale.conf

echo "FONT=ter-132b" >> /etc/vconsole.conf

echo candyland > /etc/hostname
systemctl enable NetworkManager

vim /etc/mkinitcpio.conf
# MODULES=(btrfs)
# BINARIES=(/usr/bin/btrfs)
# HOOKS=(base udev autodetect microcode modconf kms block encrypt filesystems keyboard fsck)

mkinitcpio -P

passwd # root password

mkdir -p /boot/EFI/BOOT
cp /usr/share/limine/BOOTX64.EFI /boot/EFI/BOOT/
efibootmgr --create --disk $DISK --part $ESP_PART --label "Arch Linux Limine Boot Loader" --loader '\EFI\BOOT\BOOTX64.EFI' --unicode

cryptsetup luksUUID $ROOT_DISK
vim /boot/limine.conf
`
timeout: 3

/Arch Linux
  protocol: linux
  path: boot():/vmlinuz-linux
  cmdline: cryptdevice=UUID=[device-UUID]:root root=/dev/mapper/root rootflags=subvol=@ rw rootfstype=btrfs
  module_path: boot():/initramfs-linux.img
`

exit
umount /mnt/boot
umount -l -n -R /mnt
cryptsetup close root
reboot
```

pacman -S vim neovim tree alacritty acpi fwupd htop iotop powertop thunar openssl openssh pass git amd-ucode net-tools xf86-video-amdgpu libva-mesa-driver firefox ttf-liberation ttf-droid noto-fonts ttf-bitstream-vera ttf-dejavu xorg-server xorg-server-common inetutils go dmidecode xterm i3-wm tlp xorg-xrdb xorg-apps pasystray network-manager-applet blueman dmenu xss-lock i3status ripgrep bat fd dust fzf lm_sensors brightnessctl ttf-font-awesome pipewire-pulse pipewire-alsa smplayer ffmpeg acpi jdk11-openjdk reflector rsync curl redshift cpupower xdg-user-dirs alsa-utils

su davs
    # yay
    cd /tmp; git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si && cd

    yay -S dex seahorse gnome-keyring polkit-gnome oxygen-icons ibus strace rofi python-pynvim gnome-session dunst jq yq docker-compose docker docker-buildx run-parts networkmanager-openvpn python-i3ipc xclip bash-completion symlinks thunar-archive-plugin xarchiver mise podman podman-compose
