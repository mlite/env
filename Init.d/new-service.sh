#!/bin/bash
mypath=$(dirname $(readlink -f $0))
SERVICE_FILE=$(tempfile)

while [ $# -ne 0 ]; do
    case $1 in
	"--name")
	    shift
	    NAME=$1
	    ;;
	"--description")
	    shift
	    DESCRIPTION=$1
	    ;;
	"--command")
	    shift
	    COMMAND=$1
	    ;;
	"--username")
	    shift
	    USERNAME=$1
	    ;;
	"--file")
	    shift
	    FILE=$1
	    ;;
        "--help")
            echo "$0 --name <name> --description "string" --command <cmmand> --username <username> [--file <service-file>]"
            exit 1
            ;;
    esac
    shift
done
    
prompt_token() {
  local VAL=$3
  while [ -z "$VAL" ] || [ "$VAL" = "" ]; do
    echo -n "${2:-$1} : "
    read VAL
    if [ "$VAL" = "" ]; then
      echo "Please provide a value"
    fi
  done
  VAL=$(printf '%q' "$VAL")
  eval $1=$VAL
  sed -i "s/<$1>/$(printf '%q' "$VAL")/g" $SERVICE_FILE
}

instantialize_service () {
    echo "--- Download template ---"
    cp $mypath/service.sh.in $SERVICE_FILE
    chmod +x "$SERVICE_FILE"
    echo ""
    
    echo "--- Customize ---"
    echo "I'll now ask you some information to customize script"
    echo "Press Ctrl+C anytime to abort."
    echo "Empty values are not accepted."
    echo ""
    
    prompt_token 'NAME'        'Service name' $NAME
    if [ -f "/etc/init.d/$NAME" ]; then
	echo "Error: service '$NAME' already exists"
	exit 1
    fi
    
    prompt_token 'DESCRIPTION' ' Description' $DESCRIPTION
    prompt_token 'COMMAND'     '     Command' $COMMAND
    prompt_token 'USERNAME'    '        User' $USERNAME
    if ! id -u "$USERNAME" &> /dev/null; then
	echo "Error: user '$USERNAME' not found"
	exit 1
    fi
    echo ""
}

install_init () {
    echo "--- Installation ---"
    if [ ! -w /etc/init.d ]; then
	echo "You don't gave me enough permissions to install service myself."
	echo "That's smart, always be really cautious with third-party shell scripts!"
	echo "You should now type those commands as superuser to install and run your service:"
	echo ""
	echo "   mv \"$SERVICE_FILE\" \"/etc/init.d/$NAME\""
	echo "   touch \"/var/log/$NAME.log\" && chown \"$USERNAME\" \"/var/log/$NAME.log\""
	echo "   update-rc.d \"$NAME\" defaults"
	echo "   service \"$NAME\" start"
    else
	echo "1. mv \"$SERVICE_FILE\" \"/etc/init.d/$NAME\""
	mv -v "$SERVICE_FILE" "/etc/init.d/$NAME"
	echo "2. touch \"/var/log/$NAME.log\" && chown \"$USERNAME\" \"/var/log/$NAME.log\""
	touch "/var/log/$NAME.log" && chown "$USERNAME" "/var/log/$NAME.log"
	echo "3. update-rc.d \"$NAME\" defaults"
	update-rc.d "$NAME" defaults
	echo "4. service \"$NAME\" start"
	service "$NAME" start
    fi
    echo ""
    echo "---Uninstall instructions ---"
    echo "The service can uninstall itself:"
    echo "    service \"$NAME\" uninstall"
    echo "It will simply run update-rc.d -f \"$NAME\" remove && rm -f \"/etc/init.d/$NAME\""
    echo ""
    echo "--- Terminated ---"
}


if [ -n "$FILE" ]; then
    SERVICE_FILE = $FILE
fi

instantialize_service
install_init

