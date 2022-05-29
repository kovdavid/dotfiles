#!/bin/bash

function remove_and_link_dotfile {
    $(rm -rf ~/.$1)
    $(ln -s ~/dotfiles/$1 ~/.$1)
}

function remove_and_link_dir {
    $(rm -rf ~/.$1)
    if [ -d /opt/$1 ] ; then
        $(ln -s /opt/$1 ~/.$1)
    else
        $(ln -s /tmp ~/.$1)
    fi
}

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
remove_and_link_dotfile gtkrc-2.0
remove_and_link_dotfile gtkrc-2.0.mine
remove_and_link_dotfile git_global_ignore
remove_and_link_dotfile perltidyrc
remove_and_link_dotfile ocamlinit

echo "Linking directories"
remove_and_link_dir thumbnails
remove_and_link_dir pip
remove_and_link_dir macromedia
remove_and_link_dir cpanm
remove_and_link_dir cpan
remove_and_link_dir codeintel
remove_and_link_dir bundler
remove_and_link_dir adobe

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

mkdir -p ~/.config/systemd/user
ln -sf ~/dotfiles/systemd/i3lock/i3lock.service ~/.config/systemd/user/
systemctl enable --user i3lock.service

for timer_unit in clean_daily redshift_adjust ; do
    echo "Setting up systemd-timer $timer_unit"
    ln -sf ~/dotfiles/systemd/$timer_unit/$timer_unit.timer ~/.config/systemd/user/
    ln -sf ~/dotfiles/systemd/$timer_unit/$timer_unit.service ~/.config/systemd/user/
    systemctl --user daemon-reload
    systemctl enable --user $timer_unit.timer
    systemctl restart --user $timer_unit.timer
done

~/dotfiles/bin/color_scheme dark

echo "DONE"
