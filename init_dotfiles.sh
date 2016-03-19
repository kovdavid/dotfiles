#!/bin/bash

function remove_and_link_dotfile {
    $(rm -rf ~/.$1)
    $(ln -s ~/dotfiles/$1 ~/.$1)
}

function remove_and_link_to_tmp {
    $(rm -rf ~/.$1)
    $(ln -s /tmp ~/.$1)
}

read -n 1 -p "Would you like to reinitalize dotfiles? <y/n>"
echo ""
if [ "$REPLY" = "y" ] ; then
    echo "Linking scripts"
    if [ ! -d ~/bin ] ; then
        mkdir ~/bin
    fi

    for script in $(ls ~/dotfiles/bin); do
        if [ -f ~/bin/$script ] ; then
            read -n 1 -p "~/bin/$script already exists. Delete file? <y/n>"
            echo ""
            if [ "$REPLY" = "y" ] ; then
                rm -rf ~/bin/$script
                ln -s ~/dotfiles/bin/$script ~/bin/$script
            fi
        else
            ln -s ~/dotfiles/bin/$script ~/bin/$script
        fi
    done

    echo "Linking dotfiles"
    remove_and_link_dotfile Xdefaults
    remove_and_link_dotfile Xmodmap
    remove_and_link_dotfile Xresources
    remove_and_link_dotfile bash_profile
    remove_and_link_dotfile bashrc
    remove_and_link_dotfile fontconfig
    remove_and_link_dotfile gitconfig
    remove_and_link_dotfile screenrc

    echo "You have to manually link i3/config and i3/status!"
    # remove_and_link_dotfile i3/config
    # remove_and_link_dotfile i3/status

    remove_and_link_dotfile vim
    remove_and_link_dotfile xinitrc
    remove_and_link_dotfile tmux.conf
    remove_and_link_dotfile tmux.conf.dccn1
    remove_and_link_dotfile tmux.conf.dccn2
    remove_and_link_dotfile tmux.conf.qaccn4
    remove_and_link_dotfile tmux.conf.vtccn1
    remove_and_link_dotfile xprofile
    remove_and_link_dotfile xsessionrc
    remove_and_link_dotfile gtkrc-2.0
    remove_and_link_dotfile gtkrc-2.0.mine
    remove_and_link_dotfile git_global_ignore
    remove_and_link_dotfile perltidyrc

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
    if [ ! -d ~/.irssi ] ; then
        mkdir ~/.irssi
    fi
    ln -s ~/dotfiles/irssi_config ~/.irssi/config

    echo "Linking VIM"
    rm -rf ~/.vimrc
    ln -s ~/.vim/vimrc ~/.vimrc

    echo "Linking NVIM"
    rm -rf ~/.nvimrc
    rm -rf ~/.nvim
    ln -s ~/.vim/vimrc ~/.nvimrc
    ln -s ~/.vim ~/.nvim

    mkdir -p ${XDG_CONFIG_HOME:=~/.config}
    rm -rf $XDG_CONFIG_HOME/nvim
    ln -s ~/.vim $XDG_CONFIG_HOME/nvim

    echo "DONE"
fi

unset -f remove_and_link_dotfile
unset -f remove_and_link_to_tmp
