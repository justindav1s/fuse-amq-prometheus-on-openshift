#!/usr/bin/env bash

. ../amq-env.sh

oc login https://${IP} -u $USER

echo PROJECT : $PROJECT

oc delete project $PROJECT
oc new-project $PROJECT 2> /dev/null
while [ $? \> 0 ]; do
    sleep 1
    printf "."
oc new-project $PROJECT 2> /dev/null
done