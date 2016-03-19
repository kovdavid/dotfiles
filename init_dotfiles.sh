#!/bin/bash

function remove_and_link_dotfile {
    $(rm -rf /home/davs/.$1)
    $(ln -s /home/davs/dotfiles/$1 /home/davs/.$1)
}

function remove_and_link_to_tmp {
    $(rm -rf /home/davs/.$1)
    $(ln -s /tmp /home/davs/.$1)
}

read -n 1 -p "Would you like to reinitalize dotfiles? <y/n>"
echo ""
if [ "$REPLY" = "y" ] ; then
    echo "Linking scripts"
    if [ ! -d /home/davs/bin ] ; then
        mkdir /home/davs/bin
    fi

    for script in $(ls /home/davs/dotfiles/bin); do
        if [ -f "/home/davs/bin/$script" ] ; then
            read -n 1 -p "/home/davs/bin/$script already exists. Delete file? <y/n>"
            echo ""
            if [ "$REPLY" = "y" ] ; then
                rm -rf "/home/davs/bin/$script"
                ln -s "/home/davs/dotfiles/bin/$script" "/home/davs/bin/$script"
            fi
        else
            ln -s "/home/davs/dotfiles/bin/$script" "/home/davs/bin/$script"
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
    remove_and_link_dotfile i3
    remove_and_link_dotfile i3status.conf
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
    if [ ! -d "/home/davs/.irssi" ] ; then
        mkdir "/home/davs/.irssi"
    fi
    ln -s /home/davs/dotfiles/irssi_config /home/davs/.irssi/config

    echo "Linking VIM"
    rm -rf /home/davs/.vimrc
    ln -s /home/davs/.vim/vimrc /home/davs/.vimrc

    echo "Linking NVIM"
    rm -rf /home/davs/.nvimrc
    rm -rf /home/davs/.nvim
    ln -s /home/davs/.vim/vimrc /home/davs/.nvimrc
    ln -s /home/davs/.vim /home/davs/.nvim

    mkdir -p ${XDG_CONFIG_HOME:=$HOME/.config}
    rm -rf $XDG_CONFIG_HOME/nvim
    ln -s ~/.vim $XDG_CONFIG_HOME/nvim

    echo "DONE"
fi

unset -f remove_and_link_dotfile
unset -f remove_and_link_to_tmp
