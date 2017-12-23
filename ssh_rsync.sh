#!/bin/bash -x
mypath=$(dirname $(readlink -f $0))

help() {
    echo "Usage: $0 --remote-host <ip> --remote-user <usr> --remote-dir <path> --local-dir <path>"
    exit 1
}

while [ $# -ne 0 ]; do
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
            help
            ;;
    esac
    shift
done

if [ -z $REMOTE_USR ] || [ -z $REMOTE_HOST ] || [ -z $LOCAL_DIR ]; then
  help  
fi

${REMOTE_DIR:-"~/"}
rsync -avz -e "ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null" \
      --progress $LOCAL_DIR ${REMOTE_USR}@${REMOTE_HOST}:${REMOTE_DIR}
