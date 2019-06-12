#!/usr/bin/env bash

. ../amq-env.sh

oc project $PROJECT

BROKER_NUM=1
APP_NAME=${AMQ_APP_NAME_PREFIX}-${BROKER_NUM}
BUILD_NAME=${APP_NAME}-build

oc delete dc,svc,route -l app=${APP_NAME}

BROKER_NUM=2
APP_NAME=${AMQ_APP_NAME_PREFIX}-${BROKER_NUM}
oc delete dc,svc,route -l app=${APP_NAME}

BROKER_NUM=3
APP_NAME=${AMQ_APP_NAME_PREFIX}-${BROKER_NUM}
oc delete dc,svc,route -l app=${APP_NAME}

#APP_NAME=amq-postgresql
#oc delete dc,pvc,svc -l app=${APP_NAME}