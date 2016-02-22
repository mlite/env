#!/bin/bash -x
if [ "$#" -ne 3 ]; then
    echo "usage: $0 <the gpg file> <the destination folder> <passphrase>"
    exit 1;
fi

bname=`basename $1 .gpg`

if [ -f ${bname} ]; then
  mv ${bname} ${bname.bak}
fi
gpg --output ${bname} --passphrase $3 --decrypt $1 

tar xvfJ ${bname} --directory=$2


