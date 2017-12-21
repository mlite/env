#!/bin/bash
mypath=$(dirname $(readlink -f $0))

if [ "$#" -eq 1 ]; then
    U=$1
else
    U=$USER
fi
if [ "$U" == "$USER" ]; then
    su $U
fi
mkdir -p ~/bb-worker
cd ~/bb-worker

virtualenv --no-site-packages sandbox
source sandbox/bin/activate

pip install --upgrade pip
pip install buildbot-worker
# required for 'runtests' build
pip install setuptools-trial

buildbot-worker create-worker worker localhost example-worker pass

