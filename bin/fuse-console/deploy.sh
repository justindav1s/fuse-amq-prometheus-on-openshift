#!/usr/bin/env bash

PROJECT=fuse-infra

oc delete project $PROJECT
oc new-project $PROJECT 2> /dev/null
while [ $? \> 0 ]; do
    sleep 1
    printf "."
oc new-project $PROJECT 2> /dev/null
done

oc adm policy add-cluster-role-to-user cluster-admin system:serviceaccount:${PROJECT}:template-instance-controller

oc delete OAuthClient fuse73-console-oauth-client

oc new-app \
    -n ${PROJECT} \
    -f https://raw.githubusercontent.com/jboss-fuse/application-templates/application-templates-2.1.fuse-730065-redhat-00002/fis-console-cluster-template.json \
    -p ROUTE_HOSTNAME=console-${PROJECT}.app.ocp.datr.eu
