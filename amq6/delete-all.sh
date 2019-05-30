#!/usr/bin/env bash

PROJECT=amq
BROKER_NUM=1
APP_NAME=custom-amq6-broker-${BROKER_NUM}
BUILD_NAME=${APP_NAME}-build

oc delete dc,svc -l application=${APP_NAME}

BROKER_NUM=2
APP_NAME=custom-amq6-broker-${BROKER_NUM}
oc delete dc,svc -l application=${APP_NAME}

BROKER_NUM=3
APP_NAME=custom-amq6-broker-${BROKER_NUM}
oc delete dc,svc -l application=${APP_NAME}