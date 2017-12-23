#!/bin/bash
mypath=$(dirname $(readlink -f $0))

while [ $# ]; do
    case $1 in
	"--remote-dir")
	    shift
	    REMOTE_DIR=$1
	    ;;
	"--remote-host")
	    shift
	    REMOTE_HOST=$1
	    ;;
	"--remote-user")
	    shift
	    REMOTE_USR=$1
	    ;;
	"--local-dir")
	    shift
	    LOCAL_DIR=$1
	    ;;
	*)
	    echo "Usage: $0 --remote-host <ip> --remote-user <usr> --remote-dir <path> --local-dir <path>"
    esac
    shift
done

rsync -avz -e "ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null" \
      --progress $LOCAL_DIR ${REMOTE_USR}@${REMOTE_HOST}:${REMOTE_DIR}
