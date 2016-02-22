#!/bin/bash -x
if [ "$#" -ne 3 ]; then
    echo "usage: $0 <the gpg file> <the destination folder> <passphrase>"
    exit 1;
fi

bname=`basename $1 .gpg`

gpg --output ${bname} --passphrase $2 --decrypt $1 

tar xvfJ ${bname} --directory=$2


