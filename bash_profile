export PS1="[\u@\h:\w]\n\\$ "
set -o vi

if [ -e /etc/profile ] ; then
    source /etc/profile
fi

#heroku
if [ -d /usr/local/heroku/bin ] ; then
    export PATH=$PATH:/usr/local/heroku/bin
fi

#ssh
if [ -e ~/dotfiles/ssh-agent ] ; then
    source ~/dotfiles/ssh-agent
fi

#git
if [ -e ~/dotfiles/git-completion.bash ] ; then
    export GIT_PS1_SHOWDIRTYSTATE="yes"
    source ~/dotfiles/git-completion.bash
fi

if [ -e /home/davs/dotfiles/bash/git ] ; then
    source /home/davs/dotfiles/bash/git
    export PS1='[\u@\h:\w]\e[32m$(parse_git_branch)\e[0m\n$([ \j -gt 0 ] && echo "\j ")\\$ '
fi

#env
if [ -e /home/davs/dotfiles/bash/export ] ; then
    source /home/davs/dotfiles/bash/export
fi

#alias
if [ -e /home/davs/dotfiles/bash/alias ] ; then
    source /home/davs/dotfiles/bash/alias
fi

#perl
if [ -e /opt/perlbrew/etc/bashrc ] ; then
    export PERLBREW_HOME=/opt/perlbrew/.perlbrew
    source /opt/perlbrew/etc/bashrc
fi

#ruby
if [ -e /home/davs/.rvm/scripts/rvm ] ; then
    source /home/davs/.rvm/scripts/rvm
    export PATH=$PATH:/home/davs/.rvm/scripts/rvm
fi

#gems
if [ -d ~/.gem/ruby/2.1.0/bin ] ; then
    export PATH=$PATH:~/.gem/ruby/2.1.0/bin
fi
