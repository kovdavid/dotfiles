export PS1="[\u@\h:\w]\n\\$ "
set -o vi
/usr/games/fortune

if [ -e /etc/profile ] ; then
    source /etc/profile
fi

if [ -e ~/dotfiles/git-completion.bash ] ; then
    source ~/dotfiles/git-completion.bash
fi

if [ -e ~/dotfiles/git-prompt.sh ] ; then
    source ~/dotfiles/git-prompt.sh
    export PS1="[\u@\h:\w]\e[32m\$(__git_ps1)\e[0m\n\\$ "
fi

export TERM=xterm-256color

export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true"

export PERL_LOCAL_LIB_ROOT="$PERL_LOCAL_LIB_ROOT:/opt/perlbrew"
export PERL_MB_OPT="--install_base /opt/perlbrew"
export PERL_MM_OPT="INSTALL_BASE=/opt/perlbrew"
export PERL5LIB="/opt/perlbrew/lib/perl5:$PERL5LIB"

export JAVA_HOME="/usr/lib64/java/bin"
export PATH="$JAVA_HOME:$PATH"
export LD_LIBRARY_PATH="/usr/lib64/java/jre/lib/amd64"

export PATH="/opt/perlbrew/bin:/home/davs/bin:$PATH"

export PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'

export XZ_OPT=-9
export GZIP=-9

alias grep='grep --exclude-dir=.git'
alias cp="cp -i"
alias cpr="cp -i -r"
alias iptraf="iptraf -u"
alias less="less -R"
alias ..="cd .."
alias ll="ls -lh"
alias la="ls -lha"
alias lla="ls -lha"
alias clr="clear"
alias ls="ls --color=auto"
alias mv="mv -i"
alias rm="rm -i"
alias ssh="ssh -A"
alias vi="vim-term"
alias vim="vim-term"
alias w0="wget -O /dev/null"
alias up="cd \`git root\`"
alias upt="cd \`git root\` && cd t"
alias ipcalc="ipcalc -n"
alias dus="du -shc .??* * | sort -h"
alias pl="perl"
alias py="python"

if [ -e /opt/perlbrew/etc/bashrc ] ; then
    source /opt/perlbrew/etc/bashrc
fi

export PERLBREW_HOME=/opt/perlbrew/.perlbrew
source /opt/perlbrew/etc/bashrc

##LAST_BACKUP=$(cat /home/davs/.last_backup)
##if [ ! -f /home/davs/.last_backup ] ; then
    ##echo "run_backup" > /home/davs/.last_backup
##fi
##if [ "$LAST_BACKUP" != `date +%Y-%m-%d` ] ; then
    ##echo ""
    ##echo "Last backup: $LAST_BACKUP"
    ##echo ""
    ##read -n 1 -p "Would you like to run a backup? <y/n>"
    ##if [ "$REPLY" = "y" ] ; then
        ##echo ""
        ##/home/davs/bin/backup_hdd
        ##echo "`date +%Y-%m-%d`" > /home/davs/.last_backup
    ##fi
##fi

if [ ! -f /home/davs/.last_backup ] ; then
    echo ""
    read -n 1 -p "Would you like to run a backup? <y/n>"
    if [ "$REPLY" = "y" ] ; then
        echo ""
        echo "`date +%Y-%m-%d`" > /home/davs/.last_backup
        /home/davs/bin/backup_hdd
        echo "DONE"
    fi
fi
