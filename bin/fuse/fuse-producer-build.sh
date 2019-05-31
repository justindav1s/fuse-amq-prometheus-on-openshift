#!/usr/bin/env bash

. ./env.sh

oc project ${PROJECT}

APP_NAME=producer-app
BUILD_NAME=${APP_NAME}-build

oc delete is ${APP_NAME}
oc delete bc ${BUILD_NAME}

oc process -f ../../templates/fuse-app-bc-template.yaml \
  -p BUILD_NAME=${BUILD_NAME}  \
  -p APPLICATION_NAME=${APP_NAME}  \
  -p GIT_REPO="https://github.com/justindav1s/amq.git"  \
  -p GIT_BRANCH=master  \
  -p GIT_REPO_CONTEXT="fuse/${APP_NAME}"  \
  -p FUSE_IMAGE="fuse7-java-openshift" \
  -p FUSE_IMAGE_TAG="1.2" \
  -p FUSE_IMAGE_NS="openshift" \
  -p MAVEN_ARGS="package -DskipTests -Dfabric8.skip -e -B" | oc create -f -

oc start-build ${BUILD_NAME}

oc logs bc/${BUILD_NAME} -f