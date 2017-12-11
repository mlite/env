#!/bin/bash
mkdir -p ~/bb-master
cd ~/bb-master
virtualenv --no-site-packages sandbox
source sandbox/bin/activate

pip install --upgrade pip
pip install service_identity
pip install buildbot-grid-view
pip install buildbot_travis
buildbot create-master master
cp master/master.cfg.sample master/master.cfg
buildbot start master
