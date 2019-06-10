#!/usr/bin/env bash

. ../global-env.sh

export PROJECT=tmp

export CUSTOM_IMAGE_NAME="custom-amq6"
export CUSTOM_IMAGE_TAG="latest"
export CUSTOM_IMAGE_NS=${PROJECT}