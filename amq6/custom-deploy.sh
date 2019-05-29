#!/usr/bin/env bash

PROJECT=amq
APP_NAME=custom-amq6-broker1
BUILD_NAME=${APP_NAME}-build

oc delete is ${APP_NAME}
oc delete bc ${BUILD_NAME}

oc new-app -f custom-amq63-postgres-persistent.yml \
  -p APPLICATION_NAME=${APP_NAME}  \
  -p MQ_PROTOCOL="openwire"  \
  -p MQ_QUEUES=""  \
  -p MQ_TOPICS=""  \
  -p MQ_SERIALIZABLE_PACKAGES="" \
  -p ="" \
  -p ="" \
  -p ="" \
  -p ="" \
  -p ="" \
  -p ="" \
  -p ="" \
  -p ="" \
  -p ="" \


oc start-build ${BUILD_NAME}

oc logs bc/${BUILD_NAME} -f