#!/usr/bin/env bash

PROJECT=amq
APP_NAME=custom-amq6
BUILD_NAME=${APP_NAME}-build

oc delete is ${APP_NAME}
oc delete bc ${BUILD_NAME}

oc process -f build-config.yaml \
  -p BUILD_NAME=${BUILD_NAME}  \
  -p APPLICATION_NAME=${APP_NAME}  \
  -p GIT_REPO="https://github.com/justindav1s/amq.git"  \
  -p GIT_BRANCH=master  \
  -p GIT_REPO_CONTEXT="amq6/custom-amq"  \
  | oc create -f -

oc start-build ${BUILD_NAME}

oc logs bc/${BUILD_NAME} -f