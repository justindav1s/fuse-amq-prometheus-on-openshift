#!/usr/bin/env bash

HOST=openshift.nonprod.theosmo.com
USER=justind
PROJECT=cd-improvements
APPLICATION_NAME=broker

oc login https://${HOST}:8443 -u $USER

oc project ${PROJECT}

POD1_NAME=broker-amq-0
POD2_NAME=broker-amq-1
POD3_NAME=broker-amq-2

oc delete route ${POD1_NAME}-route
oc delete route ${POD2_NAME}-route
oc delete route ${POD3_NAME}-route
oc delete svc ${POD1_NAME}-jolokia-service
oc delete svc ${POD2_NAME}-jolokia-service
oc delete svc ${POD3_NAME}-jolokia-service

oc new-app -f ../../templates/amq7-hawtio-routes-template.yaml \
   -p APPLICATION_NAME=broker \
   -p POD1_NAME=${POD1_NAME} \
   -p POD2_NAME=${POD2_NAME} \
   -p POD3_NAME=${POD3_NAME}
