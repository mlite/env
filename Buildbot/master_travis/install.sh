#!/bin/bash
mypath=$(dirname $(readlink -f $0))

${mypath}/create_user.sh
sudo -u buildbot_master ${mypath}/install_as_user.sh
${mypath}/make_it_daemon.sh
