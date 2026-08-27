#!/bin/bash

set -e

DIR=${1:-/opt/clean_daily}

echo "DIR:$DIR"

if [ ! -d $DIR ] ; then
    exit
fi

cd $DIR

touch mise.toml
MISE=$(cat mise.toml)

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

echo -e "$MISE" > mise.toml
