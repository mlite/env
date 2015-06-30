#!/bin/bash
if [ "$#" -ne 3 ]; then
    echo "usage: $0 <the gpg file> <the password> <the destination folder>"
    exit 1;
fi

bname=`basename $1 .gpg`

gpg --cipher-algo AES256 --symmetric --passphrase $2 -d $1 --output ${bname}

tar xvfJ ${bname} -C $3


