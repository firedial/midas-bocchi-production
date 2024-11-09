#!/bin/bash

sudo cat <<EOS > /etc/systemd/system/button.service
[Unit]
Description=My Script Service
After=network.target

[Service]
ExecStart=nohup python button.py > /dev/null 2>&1 &
WorkingDirectory=/home/pi/midas-bocchi-production/
Restart=always
User=pi

[Install]
WantedBy=multi-user.target
EOS

sudo systemctl enable button.service
