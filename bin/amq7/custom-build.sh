#!/usr/bin/env bash

# jboss-amq-63:1.3

. ../amq-env.sh

CUSTOM_IMAGE_NAME="custom-amq7"
APP_NAME=${CUSTOM_IMAGE_NAME}

PROJECT=amq7

oc project ${PROJECT}

BUILD_NAME=${APP_NAME}-docker-build
oc delete bc ${BUILD_NAME}

oc secrets new-dockercfg rh-pull-secret \
    --docker-server=registry.redhat.io \
    --docker-username=${RHDN_USERNAME} \
    --docker-password=${RHDN_PASSWORD} \
    --docker-email=openshift@openshift.com

oc secrets link builder rh-pull-secret

BUILD_NAME=${APP_NAME}-docker-build
oc delete is ${APP_NAME}
oc delete bc ${BUILD_NAME}

# Docker build to add postgres and prometheus drivers (do this one last, as the s2i build can blow away changes made by this one)
oc process -f ../../templates/custom-amq6-docker-bc-template.yaml \
  -p BUILD_NAME=${BUILD_NAME}  \
  -p APPLICATION_NAME=${APP_NAME}  \
  -p GIT_REPO="https://github.com/justindav1s/amq.git"  \
  -p GIT_BRANCH=master  \
  -p GIT_REPO_CONTEXT="custom-images/amq7"  \
  -p OUTPUT_IMAGE_TAG="latest" \
  | oc create -f -

oc start-build ${BUILD_NAME}
oc logs bc/${BUILD_NAME} -f





