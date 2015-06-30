#!/bin/bash
if [ "$#" -ne 2 ]; then
    echo "usage: $0 <the folder> <the password>"
    exit 1;
fi

bname=`basename $1`

if [ -f "${bname}.tar.xz" ]; then
    rm ${bname}.tar.xz
fi
tar cfJ ${bname}.tar.xz  $1

if [ -f "${bname}.tar.xz.gpg" ]; then
    rm ${bname}.tar.xz.gpg
fi

gpg --cipher-algo AES256 --symmetric --passphrase $2 ${bname}.tar.xz
