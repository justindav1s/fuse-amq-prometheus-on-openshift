#!/usr/bin/env bash

. ../../fuse-env.sh

oc project ${PROJECT}

APP_NAME=producer-app
AMQ_NAMESPACE=amq7

oc delete dc,svc -l app=${APP_NAME}

oc process -f ../../templates/fuse-app-deployment-template.yaml \
  -p APP_NAME=${APP_NAME} \
  -p AMQ_HOST="custom-amq6-broker-1-amq-amqp.${AMQ_NAMESPACE}.svc,custom-amq6-broker-2-amq-amqp.${AMQ_NAMESPACE}.svc" \
  -p AMQ_CONNECTION_STRING="failover:(amqp://${AMQ_APP_NAME_PREFIX}-1-amq-amqp.${AMQ_NAMESPACE}.svc:5672,amqp://${AMQ_APP_NAME_PREFIX}-2-amq-amqp.${AMQ_NAMESPACE}.svc:5672)?initialReconnectDelay=100" \
  -p AMQ_USERNAME="admin" \
  -p AMQ_PASSWORD="changeme" \
  -p APP_IMAGE=${APP_NAME} \
  -p APP_IMAGE_TAG="latest" \
  -p APP_IMAGE_NS=${PROJECT} | oc create -f -

sleep 2

oc logs dc/${APP_NAME} -f


