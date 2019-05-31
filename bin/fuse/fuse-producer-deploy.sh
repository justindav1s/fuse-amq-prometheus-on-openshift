#!/usr/bin/env bash

. ./env.sh

oc project ${PROJECT}

APP_NAME=producer-app

oc delete dc -l app=${APP_NAME}

oc process -f ../../templates/fuse-app-deployment-template.yaml \
  -p APP_NAME=${APP_NAME} \
  -p AMQP_HOST="custom-amq6-broker-1-amq-amqp.amq.svc,custom-amq6-broker-2-amq-amqp.amq.svc" \
  -p AMQP_CONNECTION_STRING="failover:(amqp://custom-amq6-broker-1-amq-amqp.amq.svc:5672,amqp://custom-amq6-broker-2-amq-amqp.amq.svc:5672)?initialReconnectDelay=100" \
  -p AMQP_USERNAME="justindav1s" \
  -p AMQP_PASSWORD="password" \
  -p APP_IMAGE=${APP_NAME} \
  -p APP_IMAGE_TAG="latest" \
  -p APP_IMAGE_NS=${PROJECT} | oc create -f -

sleep 2

oc logs dc/${APP_NAME} -f


