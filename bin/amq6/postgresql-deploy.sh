#!/usr/bin/env bash

. ../amq-env.sh

APP_NAME=amq-postgresql

oc project $PROJECT

oc delete dc,pvc,svc -l app=${APP_NAME}

oc new-app -f ../../templates/postgresql-persistent-template.yaml \
  -p APP_NAME=${APP_NAME}  \
  -p POSTGRESQL_SERVICE_NAME=${POSTGRESQL_SERVICE_NAME} \
  -p DB_NAME=${POSTGRESQL_DB_NAME} \
  -p DB_USERNAME=${POSTGRESQL_USERNAME} \
  -p DB_PASSWORD=${POSTGRESQL_PASSWORD} \
  -p VOLUME_GB="1" \
  -p MEMORY_LIMIT="1" \
  -p IMAGE_NAME="postgresql" \
  -p IMAGE_TAG="9.6" \
  -p IMAGE_NAMESPACE="openshift" \
  -p REPOSITORY_URL="docker-registry.default.svc:5000"

oc rollout status dc/${APP_NAME} -w

sleep 2

export POD=$(oc get pod -l app=${APP_NAME} | grep -m1 ${APP_NAME} | awk '{print $1}')

echo POD = $POD

oc cp data.sh $POD:/opt/app-root/src

oc exec $POD ./data.sh

#oc port-forward $POD 5000:5432

#oc rsh $POD