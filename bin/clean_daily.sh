#!/bin/bash

set -e

if [[ $(uname -a) == Darwin* ]] ; then
    DIR=${1:-/opt/clean_daily}
else
    DIR=${1:-/clean_daily}
fi

echo "DIR:$DIR"

if [ ! -d $DIR ] ; then
    exit
fi

cd $DIR

touch mise.toml
ENVRC=$(cat mise.toml)

eval "$(mise env -s bash)"

# mise.toml
# [tools]
# node = "22"
#
# [hooks]
# enter = """
# touch dalsik_daemon.log
# touch drk_daemon.log
# """

sudo find . -type f -mmin +1440 -delete

if [[ $(uname -a) == Darwin* ]] ; then
    sudo find . -type l ! -exec test -e {} \; -delete
else
    sudo find -xtype l -delete
fi

sudo find . -type d -empty -delete

echo -e "$ENVRC" > mise.toml
