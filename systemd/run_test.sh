#!/bin/bash

sudo ln -sf $PWD/test_xclip.service  /etc/systemd/user/

sudo systemctl daemon-reload
systemctl enable  --user test_xclip.service
systemctl start   --user test_xclip.service

sleep 1

systemctl status   --user test_xclip.service
