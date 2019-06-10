#!/usr/bin/env bash

PROJECT=amq

APP_NAME=amq-postgresql

oc delete dc,pvc,svc -l app=${APP_NAME}

oc new-app -f ../../templates/postgresql-persistent-template.yml \
  -p APP_NAME=${APP_NAME}  \
  -p DB_NAME="amq" \
  -p DB_USERNAME="amq" \
  -p DB_PASSWORD="amq" \
  -p VOLUME_GB=1 \
  -p MEMORY_LIMIT=1 \
  -p IMAGE_NAME="postgresql" \
  -p IMAGE_TAG="9.6" \
  -p IMAGE_NAMESPACE="openshift" \
  -p REPOSITORY_URL="docker-registry.default.svc:5000"