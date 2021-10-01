#!/bin/bash

sudo ln -sf $PWD/i3lock.service  /etc/systemd/user/

sudo systemctl daemon-reload
systemctl enable --user i3lock.service
