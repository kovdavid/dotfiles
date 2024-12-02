#!/bin/bash

set -e

DIR=${1:-/clean_daily}

echo "DIR:$DIR"

if [ ! -d $DIR ] ; then
    exit
fi

cd $DIR

touch .envrc
ENVRC=$(cat .envrc)

sudo find . -type f -mmin +1440 -delete
sudo find -xtype l -delete
sudo find . -type d -empty -delete

echo $ENVRC > .envrc
