if [ -e /home/davs/dotfiles/bash/common ] ; then
    source /home/davs/dotfiles/bash/common
fi

#ssh
if [ ! -f /home/davs/dotfiles/nike ] ; then
    if [ -e /home/davs/dotfiles/ssh-agent ] ; then
        source /home/davs/dotfiles/ssh-agent
    fi
fi
