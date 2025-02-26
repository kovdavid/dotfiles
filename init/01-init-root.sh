#!/bin/bash

if [ $(whoami) != "root" ] ; then
    echo "Please re-run as root"
    exit 1
fi

if [[ $(uname -a) == Darwin* ]] ; then
    echo "MacOS detected. Exiting"
    exit
fi

function ensure_user_group {
    if [ ! $(getent group $1) ] ; then
        echo "Creating group $1"
        if [ -z "$2" ] ; then
            groupadd $1
        else
            groupadd -g $2 $1
        fi
    fi
    if ! $(groups davs | tr ' ' '\n' | grep -q -w $1) ; then
        echo "Adding user to group $1"
        usermod -a -G $1 davs
    fi
}

function ensure_file_content() {
    FILE=$1
    CONTENT=$2

    if [ ! -f $FILE ] ; then
        echo "Creating $FILE"
        echo "$CONTENT" > $FILE
    fi
    if [ "$(cat $FILE)" != "$CONTENT" ] ; then
        echo "Replacing $FILE"
        cat $FILE
        echo "with"
        echo -e "$CONTENT"
        echo "$CONTENT" > $FILE
    fi
}

function ensure_sudoers_entry {
    CONTENT="%davs ALL=(ALL:ALL) NOPASSWD: ALL"
    FILE="/etc/sudoers.d/01-davs"
    ensure_file_content "$FILE" "$CONTENT"
}

function ensure_xkb_config {
    SYMBOLS_FILE="/usr/share/X11/xkb/symbols/davs"
    SYMBOLS_CONTENT=$(cat <<EOC
partial alphanumeric_keys modifier_keys
xkb_symbols "davs" {
    include "group(lalt_lshift_toggle)"
    key <RALT> { [ underscore, Multi_key, Multi_key, Multi_key ] };
    key <LSGT> { [ underscore, EuroSign, EuroSign, EuroSign ] };
    key <CAPS> { [ Escape ] };
    key <PRSC> { [ Menu, Menu, Menu, Menu ] };
};
EOC
)

    ensure_file_content "$SYMBOLS_FILE" "$SYMBOLS_CONTENT"

    EVDEV_FILE="/usr/share/X11/xkb/rules/evdev"
    EVDEV_CONTENT=$(grep -A1 -P "^!\s*option\s*=\s*symbols" $EVDEV_FILE | tail -n 1 | sed 's/\s//g')
    EVDEV_EXPECTED="\ \ davs:davs\t=\t+davs(davs)"

    if [ "$EVDEV_CONTENT" != "davs:davs=+davs(davs)" ] ; then
        echo "Adding [$EVDEV_EXPECTED] to $EVDEV_FILE"
        sed -i "/^!\s*option\s*=\s*symbols/a$EVDEV_EXPECTED" $EVDEV_FILE
    fi

    EVDEV_LST_FILE="/usr/share/X11/xkb/rules/evdev.lst"
    EVDEV_LST_CONTENT=$(grep -B2 -P '^\s*\bctrl\b' $EVDEV_LST_FILE | head -n1 | awk '{ print $1 }')
    EVDEV_LST_EXPECTED="\ \ davs                 Davs mappings\n\ \ davs:davs            Davs mappings"

    if [ "$EVDEV_LST_CONTENT" != "davs" ] ; then
        echo "Adding [$EVDEV_LST_EXPECTED] to $EVDEV_LST_FILE"
        sed -i "/^\s*ctrl\s\+/i$EVDEV_LST_EXPECTED" $EVDEV_LST_FILE
    fi

    XORG_CONF_FILE="/etc/X11/xorg.conf.d/00-keyboard.conf"
    XORG_CONF_CONTENT=$(cat <<EOC
Section "InputClass"
    Identifier "system-keyboard"
    MatchIsKeyboard "on"
    Option "XkbLayout" "us,sk"
    Option "XkbModel" "pc105"
    Option "XkbVariant" ",qwerty"
    Option "XkbOptions" "davs:davs"
EndSection
EOC
)
    ensure_file_content "$XORG_CONF_FILE" "$XORG_CONF_CONTENT"

    XORG_CONF_FILE2="/etc/X11/xorg.conf.d/01-keyboard-repeat.conf"
    XORG_CONF_CONTENT2=$(cat <<EOC
Section "InputClass"
    Identifier "Keyboard Repeat Rate"
    MatchIsKeyboard "on"
    Option "AutoRepeat" "220 40"
EndSection
EOC
)
    ensure_file_content "$XORG_CONF_FILE2" "$XORG_CONF_CONTENT2"
}

function ensure_tlp_config {
    TLP_FILE="/etc/tlp.d/01-davs.conf"
    TLP_CONTENT=$(cat <<EOC
START_CHARGE_THRESH_BAT0=60
STOP_CHARGE_THRESH_BAT0=90

DEVICES_TO_DISABLE_ON_STARTUP="bluetooth"
EOC
)

    ensure_file_content "$TLP_FILE" "$TLP_CONTENT"

    ensure_file_content "/etc/tlp.d/cpu_boost_off" $'CPU_BOOST_ON_AC=0\nCPU_BOOST_ON_BAT=0'
    ensure_file_content "/etc/tlp.d/cpu_boost_on" $'CPU_BOOST_ON_AC=1\nCPU_BOOST_ON_BAT=1'
    ensure_file_content "/etc/tlp.d/cpu_boost_ac" $'CPU_BOOST_ON_AC=1\nCPU_BOOST_ON_BAT=0'

    if [ ! -f /etc/tlp.d/02-cpu_boost.conf ] ; then
        echo "Linking 02-cpu_boost.conf to cpu_boost_ac."
        ln -sf /etc/tlp.d/cpu_boost_ac /etc/tlp.d/02-cpu_boost.conf
    fi
}

function ensure_nginx_pacman_hook {
    HOOK_FILE="/usr/share/libalpm/hooks/99-custom-nginx.hook"
    HOOK_CONTENT=$(cat <<EOC
[Trigger]
Operation = Install
Operation = Upgrade
Type = Package
Target = nginx

[Action]
Description = Link custom nginx homepage
When = PostTransaction
Exec = ln -sf /home/davs/workspace/nginx_index.html /usr/share/nginx/html/index.html
EOC
)

    ensure_file_content "$HOOK_FILE" "$HOOK_CONTENT"
}

function ensure_systemd_sleep_entry {
    HOOK_FILE="/lib/systemd/system-sleep/99-sleep-log"
    HOOK_CONTENT=$(cat <<EOC
#!/bin/sh

mkdir -p /clean_manually
echo "\`date '+%FT%T'\` \$1 \$2" >> /clean_manually/sleep.log
EOC
)

    ensure_file_content "$HOOK_FILE" "$HOOK_CONTENT"

    chmod +x $HOOK_FILE
}

function ensure_polkit_config {
    # action.id are in /usr/share/polkit-1/actions
    # try prompt with `pkexec --user davs gparted`
    # to store pass into keyring: `secret-tool store --lable 'MyLable' server MyServer user MyUser key MyKey`
    POLKIT_FILE="/etc/polkit-1/rules.d/49-nopasswd_davs.rules"
    POLKIT_CONTENT=$(cat <<EOC
/* Allow members of the wheel group to execute any actions
 * without password authentication, similar to "sudo NOPASSWD:"
 */
polkit.addRule(function(action, subject) {
    if (
        subject.isInGroup("davs")
        && (
            action.id.startsWith("org.freedesktop.udisks2")
            || action.id.startsWith("org.freedesktop.NetworkManager")
            || action.id.startsWith("org.blueman")
        )
    ) {
        return polkit.Result.YES;
    }
});
EOC
)

    ensure_file_content "$POLKIT_FILE" "$POLKIT_CONTENT"
}

## START

if [ $(id davs --group --name) != "davs" ] ; then
    echo "Changing primary group to davs"
    groupadd $group
    usermod -g davs davs
fi

if ! id i3lock &>/dev/null; then
    echo "Creating user i3lock. You must manually set the password with 'sudo passwd i3lock'"
    useradd --system --shell /bin/false i3lock
fi

ensure_user_group wheel
ensure_user_group autologin
ensure_user_group storage
ensure_user_group disk
ensure_user_group audio
ensure_user_group users
ensure_user_group plugdev
ensure_user_group bluetooth
ensure_user_group docker
ensure_user_group lp
ensure_user_group uucp
ensure_user_group ext_hdd 1221
ensure_user_group vboxusers

ensure_sudoers_entry
ensure_xkb_config
ensure_tlp_config
ensure_polkit_config
ensure_nginx_pacman_hook
ensure_systemd_sleep_entry

for dir in "/opt/cache" "/opt/javascript" "/clean_daily" "/clean_manually"; do
    mkdir -p "$dir"
    chown davs:davs "$dir"
done

echo "Enabling fstrim.timer"
systemctl enable fstrim.timer
systemctl start fstrim.timer

systemctl mask systemd-rfkill.socket
systemctl mask systemd-rfkill.service

systemctl enable avahi-daemon.service

# To prefer libinput over synaptics
if [ ! -f /etc/X11/xorg.conf.d/40-libinput.conf ] ; then
    echo "Linking 40-libinput.conf. Restart will be necessary"
    ln -sf /usr/share/X11/xorg.conf.d/40-libinput.conf /etc/X11/xorg.conf.d/40-libinput.conf
fi

SKU_NUMBER=$(dmidecode | grep 'SKU Number' | grep -v 'Not Specified' | sed -e 's/^\s*SKU Number:\s*//')

if [ "$SKU_NUMBER" == "LENOVO_MT_20UE_BU_Think_FM_ThinkPad T14 Gen 1" ] ; then
    # Issue with the HDMI and Internal sound card interchanging their order randombly
    # This disables sound over HDMI
    SOUND=$(cat <<EOC
options snd_hda_intel enable=1 index=0
options snd_hda_intel enable=0 index=1
EOC
)
    ensure_file_content "/etc/modprobe.d/sound.conf" "$SOUND"

    NOBEEP="blacklist pcspkr"
    ensure_file_content "/etc/modprobe.d/nobeep.conf" "$NOBEEP"

    THINKPAD_ACPI="options thinkpad_acpi fan_control=1"
    ensure_file_content "/etc/modprobe.d/thinkpad_acpi.conf" "$THINKPAD_ACPI"

    ensure_file_content "/etc/xdg/user-dirs.defaults" "DOWNLOAD=Downloads"

    THINKFAN_CONFIG_COOL=$(cat <<EOC
# There should be hwmonX directories inside the 'hwmon' path
# Inside the hwmonX we want, there is a 'name' file containing the value we need here
# Indices are for tempX_input
sensors:
  - hwmon: /sys/devices/platform/thinkpad_hwmon/hwmon
    name: thinkpad
    indices: [1]

fans:
  - tpacpi: /proc/acpi/ibm/fan

levels:
  - [0, 0, 47]
  - [1, 45, 50]
  - [2, 47, 53]
  - [3, 50, 57]
  - [4, 55, 60]
  - [5, 58, 255]
  - [6, 62, 255]
EOC
)

    ensure_file_content "/etc/thinkfan.cool.yaml" "$THINKFAN_CONFIG_COOL"

    THINKFAN_CONFIG_QUIET=$(cat <<EOC
# There should be hwmonX directories inside the 'hwmon' path
# Inside the hwmonX we want, there is a 'name' file containing the value we need here
# Indices are for tempX_input
sensors:
  - hwmon: /sys/devices/platform/thinkpad_hwmon/hwmon
    name: thinkpad
    indices: [1]

fans:
  - tpacpi: /proc/acpi/ibm/fan

levels:
  - [0, 0, 55]
  - [1, 48, 60]
  - [2, 50, 65]
  - [3, 65, 70]
  - [4, 70, 75]
  - [5, 72, 255]
EOC
)

    ensure_file_content "/etc/thinkfan.quiet.yaml" "$THINKFAN_CONFIG_QUIET"

    if [ ! -L "/etc/thinkfan.yaml" ] ; then
        ln -sf /etc/thinkfan.cool.yaml /etc/thinkfan.yaml
    fi

    THINKFAN_OVERRIDE=$(cat <<EOC
[Service]
# Decrease biasing (up to -b-10) if your fan speed changes too quickly,
# Increase biasing (up to -b20) if your fan speed changes too slowly.
Environment='THINKFAN_ARGS=-b-5'
EOC
)

    mkdir -p /etc/systemd/system/thinkfan.service.d/
    ensure_file_content "/etc/systemd/system/thinkfan.service.d/override.conf" "$THINKFAN_OVERRIDE"

    systemctl enable --now thinkfan.service
fi
