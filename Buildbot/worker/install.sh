#!/bin/bash
mypath=$(dirname $(readlink -f $0))

${mypath}/create_user.sh
${mypath}/install_as_user.sh
${mypath}/make_it_daemon.sh
