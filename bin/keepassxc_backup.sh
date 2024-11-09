#!/bin/bash

FILE="davs.kdbx"

cd ~/.keepassxc || exit 1

mkdir -p "backup"

if ! cmp -s "$FILE" "backup/last_backup"; then
    echo "Creating backup"
    cp "$FILE" "backup/$(date '+%FT%T')-$FILE"
    cp "$FILE" "backup/last_backup"
fi
