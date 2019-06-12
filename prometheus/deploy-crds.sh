#!/usr/bin/env bash

# don't run this script on ocp 3.11 onwards as this already has prometheus deployed to it.

. ./env.sh

PROJECT=fuse-infra

oc project $PROJECT

oc delete customresourcedefinitions.apiextensions.k8s.io "prometheusrules.monitoring.coreos.com"
oc delete customresourcedefinitions.apiextensions.k8s.io "servicemonitors.monitoring.coreos.com"
oc delete customresourcedefinitions.apiextensions.k8s.io "prometheuses.monitoring.coreos.com"
oc delete customresourcedefinitions.apiextensions.k8s.io "alertmanagers.monitoring.coreos.com"

oc create -f ${TEMPLATE_LOCATION}/fuse-prometheus-crd.yml