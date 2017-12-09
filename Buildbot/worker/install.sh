#!/bin/bash
mkdir -p ~/tmp/bb-worker
cd ~/tmp/bb-worker

virtualenv --no-site-packages sandbox
source sandbox/bin/activate

pip install --upgrade pip
pip install buildbot-worker
# required for 'runtests' build
pip install setuptools-trial

buildbot-worker create-worker worker localhost example-worker pass

buildbot-worker start worker
