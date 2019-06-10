#!/usr/bin/env bash

. ../amq-env.sh

BROKER_NUM=3
APP_NAME=${AMQ_APP_NAME_PREFIX}-${BROKER_NUM}
BUILD_NAME=${APP_NAME}-build

oc project $PROJECT

oc delete dc,svc -l application=${APP_NAME}

oc policy add-role-to-user view -z default

oc new-app -f ../../templates/custom-amq63-postgres-persistent.yml \
  -p APP_NAME=${APP_NAME} \
  -p MQ_PROTOCOL="openwire, amqp" \
  -p MQ_QUEUES="" \
  -p MQ_TOPICS="" \
  -p MQ_SERIALIZABLE_PACKAGES="" \
  -p MQ_USERNAME=${AMQ_USERNAME} \
  -p MQ_PASSWORD=${AMQ_PASSWORD} \
  -p AMQ_MESH_DISCOVERY_TYPE="kube" \
  -p AMQ_QUEUE_MEMORY_LIMIT="100mb" \
  -p DB_URL="jdbc:postgresql://${POSTGRESQL_SERVICE_NAME}:5432/${POSTGRESQL_DB}" \
  -p DB_USERNAME=${POSTGRESQL_USERNAME} \
  -p DB_PASSWORD=${POSTGRESQL_PASSWORD} \
  -p IMAGE_STREAM=${CUSTOM_IMAGE_NAME} \
  -p IMAGE_STREAM_TAG=${CUSTOM_IMAGE_TAG} \
  -p IMAGE_STREAM_NAMESPACE=${PROJECT} \
  -p AMQ_SECRET_CONFIG_DIR="/etc/amq-secret-config-volume"