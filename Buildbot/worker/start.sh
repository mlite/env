#!/bin/bash
mypath=$(dirname $(readlink -f $0))

source ${mypath}/sandbox/bin/activate
buildbot-worker start worker --nodaemon
