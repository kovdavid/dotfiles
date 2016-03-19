if [ -e ~/dotfiles/bash/common ] ; then
    source ~/dotfiles/bash/common
fi

#ssh
if [ ! -f ~/dotfiles/nike ] ; then
    if [ -e ~/dotfiles/ssh-agent ] ; then
        source ~/dotfiles/ssh-agent
    fi
fi
