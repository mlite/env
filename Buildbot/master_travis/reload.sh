#!/bin/bash
mypath=$(dirname $(readlink -f $0))

echo $mypath
buildbot checkconfig ${mypath}
if [ $? -eq 0 ]; then
  buildbot sighup ${mypath}
else
  echo "ill-formed configuration, don't reload"
fi
