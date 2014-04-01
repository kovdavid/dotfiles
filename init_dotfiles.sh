#!/bin/sh

function remove_and_link_dotfile {
    $(rm -rf ~/.$1)
    $(ln -s ~/dotfiles/$1 ~/.$1)
}

function remove_and_link_to_tmp {
    $(rm -rf ~/.$1)
    $(ln -s /tmp ~/.$1)
}

read -n 1 -p "Would you like to reinitalize dotfiles? <y/n>"
if [ "$REPLY" = "y" ] ; then
    remove_and_link_dotfile Xdefaults
    remove_and_link_dotfile Xmodmap
    remove_and_link_dotfile Xresources
    remove_and_link_dotfile astylerc
    remove_and_link_dotfile bash_profile
    remove_and_link_dotfile bashrc
    remove_and_link_dotfile fontconfig
    remove_and_link_dotfile fonts.conf.d
    remove_and_link_dotfile gitconfig
    remove_and_link_dotfile i3
    remove_and_link_dotfile i3status.conf
    remove_and_link_dotfile perlcriticrc
    remove_and_link_dotfile perltidyrc
    remove_and_link_dotfile profile
    remove_and_link_dotfile vim
    remove_and_link_dotfile xinitrc
    remove_and_link_dotfile xprofile
    remove_and_link_dotfile xsessionrc

    remove_and_link_to_tmp thumbnails
    remove_and_link_to_tmp pip
    remove_and_link_to_tmp macromedia
    remove_and_link_to_tmp cpanm
    remove_and_link_to_tmp codeintel
    remove_and_link_to_tmp cache
    remove_and_link_to_tmp bundler
    remove_and_link_to_tmp adobe

    rm -rf ~/.vimrc
    ln -s ~/.vim/vimrc ~/.vimrc

    echo "DONE"
fi
