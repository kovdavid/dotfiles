#!/bin/bash

function remove_and_link_dotfile {
	$(rm -rf ~/.$1)
	$(ln -s ~/dotfiles/$1 ~/.$1)
}

echo "Linking dotfiles"

ln -sf ~/dotfiles/bash/env_settings ~/.bashrc.env_settings
ln -sf ~/dotfiles/git-completion.bash ~/.bashrc.git-completion
ln -sf ~/dotfiles/tmux/completion.bash ~/.bashrc.tmux-completion
ln -sf ~/dotfiles/bash/export ~/.bashrc.export
ln -sf ~/dotfiles/bash/alias ~/.bashrc.alias
ln -sf ~/dotfiles/bash/common ~/.bashrc.common

if [ ! -f ~/.Xresources.local ]; then
	if [ $(hostname) == "neverland" ]; then
		echo "XTerm*faceSize: 13" >~/.Xresources.local
	else
		echo "You have to manually create ~/.Xresources.local"
	fi
fi

ln -sf ~/dotfiles/Xresources/Xresources ~/.Xresources

remove_and_link_dotfile bash_profile
remove_and_link_dotfile bashrc

ln -sf ~/dotfiles/gitconfig ~/.gitconfig
if [ $(hostname) == "neverland" ]; then
	echo "[user]" >~/.gitconfig.local
	echo "    name = Dávid Kovács" >>~/.gitconfig.local
	echo "    email = kovdavid@gmail.com" >>~/.gitconfig.local
else
	echo "You have to manually create ~/.gitconfig.local"
fi

rm -rf ~/.git-templates
ln -s ~/dotfiles/git-templates/ ~/.git-templates

mkdir -p ~/.config/i3
mkdir -p ~/.config/i3status

if [ $(hostname) == "neverland" ]; then
	ln -sf ~/dotfiles/i3/config.neverland ~/.config/i3/config
	ln -sf ~/dotfiles/i3/i3status-rust.neverland ~/.config/i3status/config.toml
else
	echo "You have to manually link i3/config and i3/status!"
fi

mkdir -p ~/.config/rofi

mkdir -p ~/.config/alacritty
ln -sf ~/dotfiles/alacritty/config.toml ~/.config/alacritty/alacritty.toml

ln -sf ~/dotfiles/tmux/tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/tmux/templates ~/.tmux_templates

mkdir -p ~/.config/Thunar
ln -sf ~/dotfiles/Thunar/uca.xml ~/.config/Thunar/uca.xml

remove_and_link_dotfile xinitrc
remove_and_link_dotfile inputrc
remove_and_link_dotfile xprofile
remove_and_link_dotfile gtkrc-2.0
remove_and_link_dotfile gtkrc-2.0.mine
remove_and_link_dotfile git_global_ignore
remove_and_link_dotfile npmrc

mkdir -p ~/.config/pnpm
rm -f ~/.config/pnpm/rc
ln -s -f ~/dotfiles/pnpm ~/.config/pnpm/rc

echo "IRSSI"
mkdir -p ~/.irssi
ln -s -f ~/dotfiles/irssi_config ~/.irssi/config

echo "Linking NVIM"
rm -rf ~/.config/nvim
rm -rf ~/.vim
ln -sf ~/dotfiles/nvim ~/.config/nvim

ln -sf ~/dotfiles/redshift.conf ~/.config/redshift.conf

echo "Linking mimeapps.list"
mkdir -p ~/.local/share/applications
ln -f -s ~/dotfiles/mimeapps.list ~/.local/share/applications/mimeapps.list
ln -f -s ~/dotfiles/mimeapps.list ~/.local/share/applications/defaults.list
ln -f -s ~/dotfiles/mimeapps.list ~/.config/mimeapps.list

echo "Creating keepassxc autostart service"
KEEPASSXC_FILE="${XDG_DATA_HOME:-$HOME/.local/share}/dbus-1/services/org.freedesktop.secrets.service"
mkdir -p $(dirname "$KEEPASSXC_FILE")
echo "[D-BUS Service]" >"$KEEPASSXC_FILE"
echo "Name=org.freedesktop.secrets" >>"$KEEPASSXC_FILE"
echo "Exec=/usr/bin/keepassxc" >>"$KEEPASSXC_FILE"

~/dotfiles/bin/color_scheme dark

echo "DONE"
