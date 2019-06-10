#!/usr/bin/env bash

. ../amq-env.sh

BROKER_NUM=1
APP_NAME=${AMQ_APP_NAME_PREFIX}-${BROKER_NUM}
BUILD_NAME=${APP_NAME}-build
POSTGRESQL_DB=amq_${BROKER_NUM}

oc project $PROJECT

oc delete dc,svc -l app=${APP_NAME}
oc delete secret ${APP_NAME}-secret-config

oc policy add-role-to-user view -z default

oc create secret generic ${APP_NAME}-secret-config \
    --from-file=activemq.xml=config/activemq.xml \
    --from-file=users.properties=config/users.properties \
    --from-file=log4j.properties=config/log4j.properties

sleep 2

oc new-app -f ../../templates/custom-amq63-postgres-persistent.yml \
  -p APP_NAME=${APP_NAME}  \
  -p MQ_PROTOCOL="openwire, amqp"  \
  -p MQ_QUEUES=""  \
  -p MQ_TOPICS=""  \
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