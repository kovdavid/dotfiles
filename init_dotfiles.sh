#!/bin/sh

function remove_and_link_dotfile {
    $(rm -rf /home/davs/.$1)
    $(ln -s /home/davs/dotfiles/$1 /home/davs/.$1)
}

function remove_and_link_to_tmp {
    $(rm -rf /home/davs/.$1)
    $(ln -s /tmp /home/davs/.$1)
}

read -n 1 -p "Would you like to reinitalize dotfiles? <y/n>"
if [ "$REPLY" = "y" ] ; then
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
    remove_and_link_dotfile tmux.conf.qaccn4
    remove_and_link_dotfile tmux.conf.vtccn1
    remove_and_link_dotfile xprofile
    remove_and_link_dotfile xsessionrc
    remove_and_link_dotfile gtkrc-2.0
    remove_and_link_dotfile gtkrc-2.0.mine

    echo "Linking to /tmp"
    remove_and_link_to_tmp thumbnails
    remove_and_link_to_tmp pip
    remove_and_link_to_tmp macromedia
    remove_and_link_to_tmp cpanm
    remove_and_link_to_tmp codeintel
    remove_and_link_to_tmp cache
    remove_and_link_to_tmp bundler
    remove_and_link_to_tmp adobe

    echo "Linking VIM"
    rm -rf /home/davs/.vimrc
    ln -s /home/davs/.vim/vimrc /home/davs/.vimrc

    echo "Linking NVIM"
    rm -rf /home/davs/.nvimrc
    rm -rf /home/davs/.nvim
    ln -s /home/davs/.vim/vimrc /home/davs/.nvimrc
    ln -s /home/davs/.vim /home/davs/.nvim

    echo "DONE"
fi

unset -f remove_and_link_dotfile
unset -f remove_and_link_to_tmp
