#!/bin/bash
mypath=$(dirname $(readlink -f $0))

if [ -f $mypath/config ]; then
  . $mypath/config
fi

cd $HOME

virtualenv --no-site-packages sandbox
source sandbox/bin/activate

pip install --upgrade pip
pip install buildbot-worker
# required for 'runtests' build
pip install setuptools-trial

echo "HOST:${BHOST}"
echo "WORKER:${BWORKER}"
echo "PASSWORD:${BPASSWORD}"

buildbot-worker create-worker worker ${BHOST} ${BWORKER} ${BPASSWORD}
