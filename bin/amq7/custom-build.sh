#!/usr/bin/env bash

# jboss-amq-63:1.3

. ../amq-env.sh

CUSTOM_IMAGE_NAME="custom-amq7"
APP_NAME=${CUSTOM_IMAGE_NAME}
BASE_IMAGE=amq-broker-73-openshift
BASE_IMAGE_TAG=7.3
BASE_IMAGE_NS=openshift

PROJECT=amq7

oc project ${PROJECT}

BUILD_NAME=${APP_NAME}-s2i-build
oc delete bc ${BUILD_NAME}

oc secrets new-dockercfg rh-pull-secret \
    --docker-server=registry.redhat.io \
    --docker-username=${RHDN_USERNAME} \
    --docker-password=${RHDN_PASSWORD} \
    --docker-email=openshift@openshift.com

oc secrets link builder rh-pull-secret

# s2i build to add custom config from configuration folder
oc process -f ../../templates/custom-amq7-s2i-bc-template.yaml \
  -p BUILD_NAME=${BUILD_NAME}  \
  -p APPLICATION_NAME=${APP_NAME}  \
  -p GIT_REPO="https://github.com/justindav1s/amq.git"  \
  -p GIT_BRANCH=master  \
  -p GIT_REPO_CONTEXT="custom-images/amq7"  \
  -p BASE_AMQ_IMAGE=${BASE_IMAGE} \
  -p BASE_AMQ_IMAGE_TAG=${BASE_IMAGE_TAG} \
  -p BASE_AMQ_IMAGE_NS=${BASE_IMAGE_NS} \
  -p OUTPUT_IMAGE_TAG="${BASE_IMAGE_TAG}.custom" \
  | oc create -f -

oc start-build ${BUILD_NAME}
oc logs bc/${BUILD_NAME} -f





