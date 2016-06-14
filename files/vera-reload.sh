#!/usr/bin/env bash

function reload {
    cd "${DIR}"
    lua *.lua || exit 1 
    xmllint *.xml || exit 1
    for f in D_*.json ; do
        json_pp < $f || exit 1
    done
    scp *.xml *.json *.lua vera:/etc/cmh-ludl/ && \
        curl 'http://vera:3480/data_request?id=reload' || exit 1
}

if [ $# == 1 ] ; then
    DIR="$1"
else
    DIR="$(pwd)"
fi
RC=0
OWD=$(pwd)
if ! ls $DIR/*.lua &> /dev/null ; then
    echo "no lua files in ${DIR}"
    exit 1
fi

while [ true ] ; do
    dialog --yesno "Deploy that sweet\nsweet\nlua\n\n?" 10 30
    if [ $? == 0 ] ; then
        reload
    else
        cd $OWD
        exit 0
    fi
done
