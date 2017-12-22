#!/bin/bash
mypath=$(dirname $(readlink -f $0))

sudo cp $mypath/buildbot.service /etc/systemd/system/buildbot.service
sudo chmod 644 /etc/systemd/system/buildbot.service

sudo systemctl daemon-reload
sudo systemctl enable buildbot.service
sudo systemctl start  buildbot.service
