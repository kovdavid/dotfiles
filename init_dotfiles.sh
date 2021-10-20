#!/bin/bash

function remove_and_link_dotfile {
    $(rm -rf ~/.$1)
    $(ln -s ~/dotfiles/$1 ~/.$1)
}

function remove_and_link_to_tmp {
    $(rm -rf ~/.$1)
    $(ln -s /tmp ~/.$1)
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
mkdir -p ~/.config/alacritty

if [ $(hostname) == "candyland" ] ; then
    ln -sf ~/dotfiles/i3/config.candyland ~/.config/i3/config
    ln -sf ~/dotfiles/i3/i3status.candyland ~/.config/i3status/config
elif [ $(hostname) == "neverland" ] ; then
    ln -sf ~/dotfiles/i3/config.neverland ~/.config/i3/config
    ln -sf ~/dotfiles/i3/i3status.neverland ~/.config/i3status/config
else
    echo "You have to manually link i3/config and i3/status!"
fi

ln -sf ~/dotfiles/alacritty.yml ~/.config/alacritty/alacritty.yml

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

ln -s -f ~/dotfiles/Xresources.zenburn ~/.Xresources.colorscheme

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

echo "DONE"

unset -f remove_and_link_dotfile
unset -f remove_and_link_to_tmp
