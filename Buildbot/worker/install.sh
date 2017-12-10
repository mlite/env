#!/bin/bash
mkdir -p ~/bb-worker
cd ~/bb-worker

virtualenv --no-site-packages sandbox
source sandbox/bin/activate

pip install --upgrade pip
pip install buildbot-worker
# required for 'runtests' build
pip install setuptools-trial

buildbot-worker create-worker worker localhost example-worker pass

# This might fail depending on the master configration
# If it fails, please fix the worker with the correct parameters
buildbot-worker start worker
