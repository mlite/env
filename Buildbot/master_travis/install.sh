#!/bin/bash
mkdir -p ~/bb-master
cd ~/bb-master
virtualenv --no-site-packages sandbox
source sandbox/bin/activate

pip install --upgrade pip
pip install service_identity
pip install 'buildbot[bundle]'
pip install buildbot_travis
bbtravis create-master master
buildbot start master
