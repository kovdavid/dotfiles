if [ -e ~/dotfiles/bash/common ] ; then
    source ~/dotfiles/bash/common
fi

#ssh
if [ ! -f ~/dotfiles/nike ] && [ -e ~/dotfiles/ssh-agent ] ; then
    source ~/dotfiles/ssh-agent
fi
