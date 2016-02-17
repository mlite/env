#!/bin/bash -x
if [ "$#" -ne 2 ]; then
    echo "usage: $0 <the gpg file> <the destination folder>"
    exit 1;
fi

bname=`basename $1 .gpg`

gpg --output ${bname} --decrypt $1 

tar xvfJ ${bname} --directory=$2


