#!/bin/bash

if [ $(whoami) != "root" ] ; then
    echo "Please re-run as root"
    exit 1
fi

function ensure_user_group {
    if [ ! $(getent group $1) ] ; then
        echo "Creating group $1"
        groupadd $1
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
    key <RALT> { [ underscore, BackSpace, BackSpace, BackSpace ] };
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
    Option "XkbOptions" "davs:davs"
EndSection
EOC
)
    ensure_file_content "$XORG_CONF_FILE" "$XORG_CONF_CONTENT"
}

function ensure_tlp_config {
    TLP_FILE="/etc/tlp.d/01-davs.conf"
    TLP_CONTENT=$(cat <<EOC
START_CHARGE_THRESH_BAT0=70
STOP_CHARGE_THRESH_BAT0=90

CPU_BOOST_ON_AC=1
CPU_BOOST_ON_BAT=0

DEVICES_TO_DISABLE_ON_STARTUP="bluetooth"
EOC
)

    ensure_file_content "$TLP_FILE" "$TLP_CONTENT"
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

ensure_user_group wheel
ensure_user_group autologin
ensure_user_group storage
ensure_user_group disk
ensure_user_group audio
ensure_user_group users
ensure_user_group plugdev
ensure_user_group bluetooth
ensure_user_group docker

if [ $(id davs --group --name) != "davs" ] ; then
    echo "Changing primary group to davs"
    groupadd $group
    usermod -g davs davs
fi

ensure_sudoers_entry
ensure_xkb_config
ensure_tlp_config
ensure_polkit_config

mkdir -p /opt/cache
chown -R davs:davs /opt/cache

sudo mkdir -p /clean_daily
sudo chown davs:davs /clean_daily

echo "Enabling fstrim.timer"
systemctl enable fstrim.timer
systemctl start fstrim.timer

systemctl mask systemd-rfkill.socket
systemctl mask systemd-rfkill.service

# To prefer libinput over synaptics
if [ ! -f /etc/X11/xorg.conf.d/40-libinput.conf ] ; then
    echo "Linking 40-libinput.conf. Restart will be necessary"
    ln -sf /usr/share/X11/xorg.conf.d/40-libinput.conf /etc/X11/xorg.conf.d/40-libinput.conf
fi
