#!/usr/bin/env bash

PROJECT=tmp
APP_NAME=custom-amq6
BUILD_NAME=${APP_NAME}-build

oc project tmp

oc delete is ${APP_NAME}
oc delete bc ${BUILD_NAME}

oc process -f ../../templates/custom-amq6-s2i-bc-template.yaml \
  -p BUILD_NAME=${BUILD_NAME}  \
  -p APPLICATION_NAME=${APP_NAME}  \
  -p GIT_REPO="https://github.com/justindav1s/amq.git"  \
  -p GIT_BRANCH=master  \
  -p GIT_REPO_CONTEXT="amq6/custom-amq"  \
  -p BASE_AMQ_IMAGE="jboss-amq-63" \
  -p BASE_AMQ_IMAGE_TAG="1.3" \
  -p BASE_AMQ_IMAGE_NS="openshift" \
  | oc create -f -

oc start-build ${BUILD_NAME}

oc logs bc/${BUILD_NAME} -f


# Docker build to add postgres and prometheus drivers
#oc process -f ../../templates/custom-amq6-docker-bc-template.yaml \
#  -p BUILD_NAME=${BUILD_NAME}  \
#  -p APPLICATION_NAME=${APP_NAME}  \
#  -p GIT_REPO="https://github.com/justindav1s/amq.git"  \
#  -p GIT_BRANCH=master  \
#  -p GIT_REPO_CONTEXT="amq6/custom-amq"  \
#  | oc create -f -
#
#oc start-build ${BUILD_NAME}
#
#oc logs bc/${BUILD_NAME} -f