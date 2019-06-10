#!/usr/bin/env bash

. ../amq-env.sh

oc project $PROJECT

BROKER_NUM=2
APP_NAME=${AMQ_APP_NAME_PREFIX}-${BROKER_NUM}

oc create secret generic ${APP_NAME}-secret-config \
    --from-file=activemq.xml=config/activemq.xml \
    --from-file=users.properties=config/users.properties \
    --from-file=log4j.properties=config/log4j.properties \
    --dry-run -o yaml | oc replace -f -

sleep 2

oc rollout latest dc/${APP_NAME}

oc rollout status dc/${APP_NAME} -w

echo DONE !