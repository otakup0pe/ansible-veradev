#!/usr/bin/env bash
set  -e

reload_vera() {
    curl "http://${VERA_HOST}:3480/data_request?id=reload"
}
reload() {
    cd "${DIR}" || exit 1
    if [ -z "$SKIP_TEST" ] ; then
        lua ./*.lua || exit 1
        if ls ./*.xml &> /dev/null ; then
            xmllint ./*.xml || exit 1
        fi
        if ls D_*.json &> /dev/null ; then
            for f in D_*.json ; do
                json_pp < "$f" || exit 1
            done
        fi
    fi
    scp ./* vera:/etc/cmh-ludl/
    reload_vera
}
RELOAD_ONLY=""
while getopts "r" arg; do
    case $arg in
        r)
            RELOAD_ONLY="ayy"
            ;;
    esac
done
if [ ! -z "$RELOAD_ONLY" ] ; then
    reload_vera
    exit 0
fi

if [ $# == 1 ] ; then
    DIR="$1"
    shift
else
    DIR="$(pwd)"
fi

TITLE="$DIR"
if [ -d "${DIR}/plugin" ] ; then
    DIR="${DIR}/plugin"
    TITLE="$(dirname "$DIR")"
    TITLE="$(basename "$TITLE")"
fi
if ! ls "$DIR"/*.lua &> /dev/null ; then
    echo "no lua files in ${DIR}"
    exit 1
fi

OWD=$(pwd)
while true ; do
    dialog --yesno "${TITLE}\nDeploy that sweet\nsweet\nlua\n\n?" 10 30
    if [ $? == 0 ] ; then
        reload        
    else
        cd "$OWD" || exit 1
        exit 0
    fi
done
