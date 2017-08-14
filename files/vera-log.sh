#!/usr/bin/env bash

while [ -z "$DONE" ] ; do
    ssh vera tail -f /var/log/cmh/LuaUPnP.log
    if [ $? != 143 ] ; then
        DONE=yes
    fi
done
