#!/usr/bin/env bash

# jboss-amq-63:1.3

. ../amq-env.sh

APP_NAME=${CUSTOM_IMAGE_NAME}
BASE_IMAGE=jboss-amq-63
BASE_IMAGE_TAG=1.3
BASE_IMAGE_NS=openshift

oc project ${PROJECT}

BUILD_NAME=${APP_NAME}-s2i-build
oc delete bc ${BUILD_NAME}

# s2i build to add custom config from configuration folder to /opt/amq/conf/
oc process -f ../../templates/custom-amq6-s2i-bc-template.yaml \
  -p BUILD_NAME=${BUILD_NAME}  \
  -p APPLICATION_NAME=${APP_NAME}  \
  -p GIT_REPO="https://github.com/justindav1s/fuse-amq-prometheus-on-openshift.git"  \
  -p GIT_BRANCH=master  \
  -p GIT_REPO_CONTEXT="custom-images/amq6"  \
  -p BASE_AMQ_IMAGE=${BASE_IMAGE} \
  -p BASE_AMQ_IMAGE_TAG=${BASE_IMAGE_TAG} \
  -p BASE_AMQ_IMAGE_NS=${BASE_IMAGE_NS} \
  -p OUTPUT_IMAGE_TAG="s2i" \
  | oc create -f -

oc start-build ${BUILD_NAME}
oc logs bc/${BUILD_NAME} -f



BUILD_NAME=${APP_NAME}-docker-build
oc delete is ${APP_NAME}
oc delete bc ${BUILD_NAME}

# Docker build to add postgres and prometheus drivers (do this one last, as the s2i build can blow away changes made by this one)
oc process -f ../../templates/custom-amq6-docker-bc-template.yaml \
  -p BUILD_NAME=${BUILD_NAME}  \
  -p APPLICATION_NAME=${APP_NAME}  \
  -p GIT_REPO="https://github.com/justindav1s/fuse-amq-prometheus-on-openshift.git"  \
  -p GIT_BRANCH=master  \
  -p GIT_REPO_CONTEXT="custom-images/amq6"  \
  -p OUTPUT_IMAGE_TAG="latest" \
  | oc create -f -

oc start-build ${BUILD_NAME}
oc logs bc/${BUILD_NAME} -f




