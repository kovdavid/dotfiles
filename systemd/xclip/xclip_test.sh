#!/bin/bash

date | xclip -i -f -selection primary
echo "Hello"
echo "$(xclip -o)"
echo "Bello"

sleep 1
