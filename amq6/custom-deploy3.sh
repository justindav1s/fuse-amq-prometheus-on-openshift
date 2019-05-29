#!/usr/bin/env bash

PROJECT=amq
BROKER_NUM=3
APP_NAME=custom-amq6-broker-${BROKER_NUM}
BUILD_NAME=${APP_NAME}-build


oc delete dc,svc -l application=${APP_NAME}

oc new-app -f custom-amq63-postgres-persistent.yml \
  -p APPLICATION_NAME=${APP_NAME}  \
  -p MQ_PROTOCOL="openwire"  \
  -p MQ_QUEUES=""  \
  -p MQ_TOPICS=""  \
  -p MQ_SERIALIZABLE_PACKAGES="" \
  -p MQ_USERNAME="justindav1s" \
  -p MQ_PASSWORD="password" \
  -p AMQ_MESH_DISCOVERY_TYPE="dns" \
  -p AMQ_QUEUE_MEMORY_LIMIT="100mb" \
  -p DB_URL="jdbc:postgresql://amq1-postgresql:5432/amq_${BROKER_NUM}" \
  -p DB_USERNAME="amq" \
  -p DB_PASSWORD="amq" \
  -p IMAGE_STREAM="custom-amq6" \
  -p IMAGE_STREAM_TAG="latest" \
  -p IMAGE_STREAM_NAMESPACE="amq"