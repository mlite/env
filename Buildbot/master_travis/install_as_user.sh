#!/bin/bash
cd $HOME
virtualenv --no-site-packages $HOME/sandbox
source sandbox/bin/activate

pip install --upgrade pip
pip install service_identity
pip install 'buildbot[bundle]'
pip install buildbot_travis
bbtravis create-master master
buildbot start master
