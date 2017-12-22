#!/bin/bash
mypath=$(dirname $(readlink -f $0))

sudo cp $mypath/buildbot-worker.service /etc/systemd/system/buildbot-worker.service
sudo chmod 644 /etc/systemd/system/buildbot-worker.service

sudo systemctl daemon-reload
sudo systemctl enable buildbot-worker.service
sudo systemctl start  buildbot-worker.service
