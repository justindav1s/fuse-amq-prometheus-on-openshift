#!/usr/bin/env bash

. ../global-env.sh

export PROJECT=tmp

export APP_NAME_PREFIX=custom-amq6-broker
export CUSTOM_IMAGE_NAME="custom-amq6"
export CUSTOM_IMAGE_TAG="latest"
export CUSTOM_IMAGE_NS=${PROJECT}