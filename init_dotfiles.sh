#!/bin/bash

function cleanup {
    unset -f remove_and_link_dotfile
    unset -f remove_and_link_to_tmp
    unset -f ensure_user_group
    unset -f ensure_sudoers_entry
    unset -f ensure_xkb
    unset -f ensure_tlp
    unset -f ensure_file_content_root
    unset -f ensure_polkit
}

function remove_and_link_dotfile {
    $(rm -rf ~/.$1)
    $(ln -s ~/dotfiles/$1 ~/.$1)
}

function remove_and_link_to_tmp {
    $(rm -rf ~/.$1)
    if [ -d /opt/$1 ] ; then
        $(ln -s /opt/$1 ~/.$1)
    else
        $(ln -s /tmp ~/.$1)
    fi
}

function ensure_user_group {
    if [ ! $(getent group $1) ] ; then
        echo "Creating group $1"
        sudo groupadd $1
    fi
    if ! $(groups $USER | tr ' ' '\n' | grep -q -w $1) ; then
        echo "Adding user to group $1"
        sudo usermod -a -G $1 $USER
    fi
}

function ensure_file_content_root() {
    FILE=$1
    CONTENT=$2

    sudo -s -- <<EOF
        [ ! -f $FILE ] && echo "Creating $FILE" && echo "$CONTENT" > $FILE
        [ "\$(cat $FILE)" != "$CONTENT" ] && echo "Replacing $FILE" && cat $FILE && echo "$CONTENT" > $FILE
        exit 0
EOF
}

function ensure_sudoers_entry {
    CONTENT="%$USER ALL=(ALL:ALL) NOPASSWD: ALL"
    FILE="/etc/sudoers.d/01-$USER"
    ensure_file_content_root "$FILE" "$CONTENT"
}

function ensure_xkb {
    SYMBOLS_FILE="/usr/share/X11/xkb/symbols/davs"
    SYMBOLS_CONTENT=$(cat <<EOC
partial alphanumeric_keys modifier_keys
xkb_symbols \"davs\" {
    include \"group(lalt_lshift_toggle)\"
    key <RALT> { [ underscore, BackSpace, BackSpace, BackSpace ] };
    key <LSGT> { [ underscore, EuroSign, EuroSign, EuroSign ] };
    key <CAPS> { [ Escape ] };
};
EOC
)

    ensure_file_content_root "$SYMBOLS_FILE" "$SYMBOLS_CONTENT"

    EVDEV_FILE="/usr/share/X11/xkb/rules/evdev"
    EVDEV_CONTENT=$(grep -A1 -P "^!\s*option\s*=\s*symbols" $EVDEV_FILE | tail -n 1 | sed 's/\s//g')
    EVDEV_EXPECTED="\ \ davs:davs\t=\t+davs(davs)"

    if [ "$EVDEV_CONTENT" != "davs:davs=+davs(davs)" ] ; then
        echo "Adding [$EVDEV_EXPECTED] to $EVDEV_FILE"
        sudo sed -i "/^!\s*option\s*=\s*symbols/a$EVDEV_EXPECTED" $EVDEV_FILE
    fi

    EVDEV_LST_FILE="/usr/share/X11/xkb/rules/evdev.lst"
    EVDEV_LST_CONTENT=$(grep -B2 -P '^\s*\bctrl\b' $EVDEV_LST_FILE | head -n1 | awk '{ print $1 }')
    EVDEV_LST_EXPECTED="\ \ davs                 Davs mappings\n\ \ davs:davs            Davs mappings"

    if [ "$EVDEV_LST_CONTENT" != "davs" ] ; then
        echo "Adding [$EVDEV_LST_EXPECTED] to $EVDEV_LST_FILE"
        sudo sed -i "/^\s*ctrl\s\+/i$EVDEV_LST_EXPECTED" $EVDEV_LST_FILE
    fi

    XORG_CONF_FILE="/etc/X11/xorg.conf.d/00-keyboard.conf"
    XORG_CONF_CONTENT=$(cat <<EOC
Section \"InputClass\"
    Identifier \"system-keyboard\"
    MatchIsKeyboard \"on\"
    Option \"XkbLayout\" \"us,sk\"
    Option \"XkbModel\" \"pc105\"
    Option \"XkbOptions\" \"davs:davs\"
EndSection
EOC
)
    ensure_file_content_root "$XORG_CONF_FILE" "$XORG_CONF_CONTENT"
}

function ensure_polkit {
    # action.id are in /usr/share/polkit-1/actions
    # try prompt with `pkexec --user davs gparted`
    # to store pass into keyring: `secret-tool store --lable 'MyLable' server MyServer user MyUser key MyKey`
    POLKIT_FILE="/etc/polkit-1/rules.d/49-nopasswd_davs.rules"
    POLKIT_CONTENT=$(cat <<EOC
/* Allow members of the wheel group to execute any actions
 * without password authentication, similar to \"sudo NOPASSWD:\"
 */
polkit.addRule(function(action, subject) {
    if (
        subject.isInGroup(\"davs\")
        && (
            action.id.startsWith(\"org.freedesktop.udisks2\")
            || action.id.startsWith(\"org.freedesktop.NetworkManager\")

        )
    ) {
        return polkit.Result.YES;
    }
});
EOC
)

    ensure_file_content_root "$POLKIT_FILE" "$POLKIT_CONTENT"
}

function ensure_tlp {
    TLP_FILE="/etc/tlp.d/01-davs.conf"
    TLP_CONTENT=$(cat <<EOC
START_CHARGE_THRESH_BAT0=70
STOP_CHARGE_THRESH_BAT0=90

CPU_BOOST_ON_AC=1
CPU_BOOST_ON_BAT=0

DEVICES_TO_DISABLE_ON_STARTUP=\"bluetooth\"
EOC
)

    ensure_file_content_root "$TLP_FILE" "$TLP_CONTENT"
}

ensure_user_group $USER
ensure_user_group wheel
ensure_user_group autologin
ensure_user_group storage
ensure_user_group disk
ensure_user_group audio
ensure_user_group users

if [ $(id $USER --group --name) != "$USER" ] ; then
    echo "Changing primary group to $USER"
    sudo usermod -g $USER $USER
fi

sudo mkdir -p /clean_daily

ensure_sudoers_entry
ensure_xkb
ensure_tlp
ensure_polkit

echo "Linking scripts"
mkdir -p ~/bin

for script in $(ls ~/dotfiles/bin); do
	if [ -f ~/bin/$script ] ; then
		if [[ -z $(ls -l ~/bin/$script | grep dotfiles) ]] ; then
			read -n 1 -p "~/bin/$script already exists. Delete file? <y/n>"
			echo ""
			if [ "$REPLY" = "y" ] ; then
				rm -rf ~/bin/$script
				ln -s ~/dotfiles/bin/$script ~/bin/$script
			fi
		fi
	else
		ln -s ~/dotfiles/bin/$script ~/bin/$script
	fi
done

echo "Linking dotfiles"

ln -sf ~/dotfiles/dircolors            ~/.bashrc.dircolors
ln -sf ~/dotfiles/bash/env_settings    ~/.bashrc.env_settings
ln -sf ~/dotfiles/git-completion.bash  ~/.bashrc.git-completion
ln -sf ~/dotfiles/tmux-completion.bash ~/.bashrc.tmux-completion
ln -sf ~/dotfiles/bash/export          ~/.bashrc.export
ln -sf ~/dotfiles/bash/alias           ~/.bashrc.alias
ln -sf ~/dotfiles/bash/common          ~/.bashrc.common

if [ ! -f ~/.Xresources.local ] ; then
    echo "XTerm*faceSize: 11" > ~/.Xresources.local
fi

remove_and_link_dotfile Xdefaults
remove_and_link_dotfile Xmodmap
remove_and_link_dotfile Xresources
remove_and_link_dotfile bash_profile
remove_and_link_dotfile bashrc
remove_and_link_dotfile ctags
remove_and_link_dotfile fontconfig
remove_and_link_dotfile screenrc
remove_and_link_dotfile dircolors
remove_and_link_dotfile ghci

ln -sf ~/dotfiles/gitconfig ~/.gitconfig
if [ $(hostname) == "candyland" ] ; then
    echo "[user]" > ~/.gitconfig.local
    echo "    name = Dávid Kovács" >> ~/.gitconfig.local
    echo "    email = kovdavid@gmail.com" >> ~/.gitconfig.local
elif [ $(hostname) == "neverland" ] ; then
    echo "[user]" > ~/.gitconfig.local
    echo "    name = Dávid Kovács" >> ~/.gitconfig.local
    echo "    email = david.kovacs@vacuumlabs.com" >> ~/.gitconfig.local
else
    echo "You have to manually create ~/.gitconfig.local"
fi

rm -rf ~/.git-templates
ln -s ~/dotfiles/git-templates/ ~/.git-templates

mkdir -p ~/.config/i3
mkdir -p ~/.config/i3status

if [ $(hostname) == "candyland" ] ; then
    ln -sf ~/dotfiles/i3/config.candyland ~/.config/i3/config
    ln -sf ~/dotfiles/i3/i3status.candyland ~/.config/i3status/config
elif [ $(hostname) == "neverland" ] ; then
    ln -sf ~/dotfiles/i3/config.neverland ~/.config/i3/config
    ln -sf ~/dotfiles/i3/i3status.neverland ~/.config/i3status/config
else
    echo "You have to manually link i3/config and i3/status!"
fi

mkdir -p ~/.config/rofi

mkdir -p ~/.config/alacritty
ln -sf ~/dotfiles/alacritty/config.yml ~/.config/alacritty/alacritty.yml

remove_and_link_dotfile vim
remove_and_link_dotfile emacs.d
remove_and_link_dotfile xinitrc
remove_and_link_dotfile inputrc
remove_and_link_dotfile tmux.conf
remove_and_link_dotfile tmux_templates
remove_and_link_dotfile xprofile
remove_and_link_dotfile xsession
remove_and_link_dotfile xsessionrc
remove_and_link_dotfile gtkrc-2.0
remove_and_link_dotfile gtkrc-2.0.mine
remove_and_link_dotfile git_global_ignore
remove_and_link_dotfile perltidyrc
remove_and_link_dotfile ocamlinit

echo "Linking to /tmp"
remove_and_link_to_tmp thumbnails
remove_and_link_to_tmp pip
remove_and_link_to_tmp macromedia
remove_and_link_to_tmp cpanm
remove_and_link_to_tmp cpan
remove_and_link_to_tmp codeintel
remove_and_link_to_tmp cache
remove_and_link_to_tmp bundler
remove_and_link_to_tmp adobe

echo "IRSSI"
mkdir -p ~/.irssi
ln -s -f ~/dotfiles/irssi_config ~/.irssi/config

echo "Linking NVIM"
rm -rf ~/.config/nvim
ln -sf ~/dotfiles/vim ~/.config/nvim

ln -sf ~/dotfiles/redshift.conf ~/.config/redshift.conf

echo "Linking mimeapps.list"
mkdir -p ~/.local/share/applications
ln -f -s ~/dotfiles/mimeapps.list ~/.local/share/applications/mimeapps.list
ln -f -s ~/dotfiles/mimeapps.list ~/.config/mimeapps.list

if [ -x "$(command -v redshift)" ] ; then
	crontab -l > /tmp/mycron
	if ! grep -q "redshift_adjust.sh" /tmp/mycron ; then
		echo "Setting crontab for redshift_adjust"
		echo "*/10 * * * * ~/dotfiles/bin/redshift_adjust.sh" >> /tmp/mycron
		crontab /tmp/mycron
	fi
	if ! grep -q "clean_daily.sh" /tmp/mycron ; then
		echo "Setting crontab for clean_daily"
		echo "*/30 * * * * ~/dotfiles/bin/clean_daily.sh" >> /tmp/mycron
		crontab /tmp/mycron
    fi
	rm /tmp/mycron
fi

echo "Enabling fstrim.timer"
sudo systemctl enable fstrim.timer

mkdir -p ~/.config/systemd/user
ln -sf ~/dotfiles/systemd/i3lock/i3lock.service ~/.config/systemd/user/
systemctl enable --user i3lock.service

sudo systemctl mask systemd-rfkill.socket
sudo systemctl mask systemd-rfkill.service

# To prefer libinput over synaptics
if [ ! -f /etc/X11/xorg.conf.d/40-libinput.conf ] ; then
    echo "Linking 40-libinput.conf. Restart will be necessary"
    sudo ln -s /usr/share/X11/xorg.conf.d/40-libinput.conf /etc/X11/xorg.conf.d/40-libinput.conf
fi

~/dotfiles/bin/color_scheme dark

echo "DONE"

cleanup
unset -f cleanup
