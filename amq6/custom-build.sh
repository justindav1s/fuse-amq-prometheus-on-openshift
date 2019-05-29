#!/usr/bin/env bash

PROJECT=amq
APP_NAME=custom-amq6

oc delete bc ${APP_NAME}-build

oc process -f build-config.yaml \
  -p BUILD_NAME=${APP_NAME}-build  \
  -p APPLICATION_NAME=${APP_NAME}  \
  -p GIT_REPO="https://github.com/justindav1s/amq.git"  \
  -p GIT_BRANCH=master  \
  -p GIT_REPO_CONTEXT="custom-amq"  \
  | oc create -f -

oc start-build ${APP_NAME}-build --from-file=target/${APP_NAME}-0.0.1-SNAPSHOT.jar

oc logs bc/${APP_NAME} -f