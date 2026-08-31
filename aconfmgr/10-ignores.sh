# Ignore runtime and volatile state
IgnorePath '/etc/adjtime'
IgnorePath '/etc/ld.so.cache'
IgnorePath '/etc/machine-id'
IgnorePath '/etc/ca-certificates/extracted/*'
IgnorePath '/etc/ssl/certs/*'
IgnorePath '/etc/udev/hwdb.bin'
IgnorePath '/etc/xml/catalog'
IgnorePath '/etc/pacman.d/gnupg/*'
IgnorePath '/etc/ssh/ssh_host_*'

# Ignore sensitive auth database files (track carefully if needed)
IgnorePath '/etc/shadow'
IgnorePath '/etc/shadow-'
IgnorePath '/etc/gshadow'
IgnorePath '/etc/gshadow-'

# Ignore variable data and logs
IgnorePath '/var/log/*'
IgnorePath '/var/cache/*'
IgnorePath '/var/lib/*'
IgnorePath '/var/tmp/*'
IgnorePath '/var/spool/*'

# Ignore system mount points and temporary directories
IgnorePath '/opt'
IgnorePath '/tmp/*'
IgnorePath '/mnt/*'
IgnorePath '/media/*'
IgnorePath '/run/*'
IgnorePath '/sys/*'
IgnorePath '/proc/*'
IgnorePath '/dev/*'

# Ignore user hoes and root home directory
IgnorePath '/home/*'
IgnorePath '/root/*'

# Ignore fonts and mime caches in /usr/share
IgnorePath '/usr/share/fonts/*'
IgnorePath '/usr/share/mime/*'

# Wildcard fallback to ignore unhandled file modifications in /var and /tmp
IgnorePath '/var/**'
IgnorePath '/tmp/**'

IgnorePath '/boot/EFI/*'
IgnorePath '/boot/vmlinuz*'
IgnorePath '/boot/initramfs*'
IgnorePath '/boot/amd-ucode*'
IgnorePath '/boot/loader/random-seed'
IgnorePath '/usr/lib/udev/hwdb.bin'
IgnorePath '/etc/NetworkManager/system-connections/*'
IgnorePath '/usr/lib/modules'
IgnorePath '/usr/lib/locale'
IgnorePath '/usr/lib/gconv'
IgnorePath '/usr/lib/**/*.cache'
IgnorePath '/etc/fonts'
IgnorePath '/.snapshots'
