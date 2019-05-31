#!/usr/bin/env bash

. ./env.sh

oc project ${PROJECT}

APP_NAME=consumer-app

oc delete dc -l app=${APP_NAME}

oc process -f ../../templates/fuse-app-deployment-template.yaml \
  -p APP_NAME=${APP_NAME} \
  -p AMQP_HOST="custom-amq6-broker-3-amq-amqp.amq.svc" \
  -p AMQP_USERNAME="justindav1s" \
  -p AMQP_PASSWORD="password" \
  -p APP_IMAGE="fuse-consumer" \
  -p APP_IMAGE_TAG="latest" \
  -p APP_IMAGE_NS="tmp" | oc create -f -

sleep 2
oc logs dc/${APP_NAME} -f


