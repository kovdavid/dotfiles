#!/bin/bash

sudo ln -sf $PWD/xclip.socket  /etc/systemd/user/
sudo ln -sf $PWD/xclip.service /etc/systemd/user/

sudo systemctl daemon-reload
systemctl enable  --user xclip.socket
systemctl restart --user xclip.socket
