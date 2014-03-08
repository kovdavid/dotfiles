export PS1="[\u@\h:\w]\n\\$ "
set -o vi
/usr/games/fortune

if [ -e /etc/profile ] ; then
    source /etc/profile
fi

#heroku
if [ -d /usr/local/heroku/bin ] ; then
    export PATH=$PATH:/usr/local/heroku/bin
fi

#git
if [ -e ~/dotfiles/git-completion.bash ] ; then
    export GIT_PS1_SHOWDIRTYSTATE="yes"
    source ~/dotfiles/git-completion.bash
fi

#git
if [ -e ~/dotfiles/git-prompt.sh ] ; then
    source ~/dotfiles/git-prompt.sh
    export PS1="[\u@\h:\w]\e[32m\$(__git_ps1)\e[0m\n\\$ "
fi

if [ -e /home/davs/dotfiles/bash/export ] ; then
    source /home/davs/dotfiles/bash/export
fi

if [ -e /home/davs/dotfiles/bash/alias ] ; then
    source /home/davs/dotfiles/bash/alias
fi

#django
if [ -e /home/davs/dotfiles/django_bash_completion ] ; then
    source /home/davs/dotfiles/django_bash_completion
fi

#perl
if [ -e /opt/perlbrew/etc/bashrc ] ; then
    export PERLBREW_HOME=/opt/perlbrew/.perlbrew
    source /opt/perlbrew/etc/bashrc
fi

#ruby
if [ -e /opt/ruby/rvm/scripts/rvm ] ; then
    source /opt/ruby/rvm/scripts/rvm
    export PATH=$PATH:/opt/ruby/rvm/scripts/rvm
fi

if [ -e /home/davs/dotfiles/bash/backup ] ; then
    source /home/davs/dotfiles/bash/backup
fi

if [ -e /home/davs/dotfiles/bash/typing_test ] ; then
    source /home/davs/dotfiles/bash/typing_test
fi
