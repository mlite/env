#!/bin/bash
mypath=$(dirname $(readlink -f $0))

cd $HOME

virtualenv --no-site-packages sandbox
source sandbox/bin/activate

pip install --upgrade pip
pip install buildbot-worker
# required for 'runtests' build
pip install setuptools-trial

buildbot-worker create-worker worker localhost example-worker pass
