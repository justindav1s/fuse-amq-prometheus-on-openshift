#!/usr/bin/env bash

. ../amq-env.sh

APP_NAME=amq-mesh

oc project $PROJECT

oc delete svc -l app=${APP_NAME}

oc new-app -f ../../templates/amq-mesh-service-template.yaml \
  -p APP_NAME=${APP_NAME}  \
  -p AMQ_MESH_SERVICE_NAME="amq-mesh"