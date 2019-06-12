#!/usr/bin/env bash


PROJECT=amq
oc project ${PROJECT}

oc delete prometheus.monitoring.coreos.com prometheus -n $PROJECT
oc delete service prometheus -n $PROJECT
oc delete serviceaccount prometheus -n $PROJECT
oc delete route.route.openshift.io prometheus -n $PROJECT
oc delete clusterrolebindings.rbac.authorization.k8s.io "prometheus-operator" -n $PROJECT
oc delete clusterroles.rbac.authorization.k8s.io "prometheus-operator" -n $PROJECT
oc delete clusterrolebindings.rbac.authorization.k8s.io "prometheus" -n $PROJECT
oc delete clusterroles.rbac.authorization.k8s.io "prometheus" -n $PROJECT
oc delete deployments.apps "prometheus-operator" -n $PROJECT
oc delete serviceaccounts "prometheus-operator" -n $PROJECT
oc delete servicemonitor.monitoring.coreos.com custom-amq6-broker-1-prometheus-servicemonitor -n $PROJECT
oc delete servicemonitor.monitoring.coreos.com custom-amq6-broker-2-prometheus-servicemonitor -n $PROJECT
oc delete servicemonitor.monitoring.coreos.com custom-amq6-broker-3-prometheus-servicemonitor -n $PROJECT
oc delete servicemonitor.monitoring.coreos.com consumer-app-prometheus-servicemonitor -n $PROJECT
oc delete servicemonitor.monitoring.coreos.com producer-app-prometheus-servicemonitor -n $PROJECT


oc process -f prometheus-operator.yaml \
    -p NAMESPACE=${PROJECT} \
   | oc create -f -


SERVICE_NAMESPACE=amq

oc process -f servicemonitor-template.yaml \
    -p SERVICE_NAMESPACE=${SERVICE_NAMESPACE} \
    -p SERVICE_NAME=custom-amq6-broker-1-prometheus \
    -p ENDPOINT_PORT="prometheus" \
    -p APP_LABEL=custom-amq6-broker-1 \
    | oc apply -f -

oc process -f servicemonitor-template.yaml \
    -p SERVICE_NAMESPACE=${SERVICE_NAMESPACE} \
    -p SERVICE_NAME=custom-amq6-broker-2-prometheus \
    -p ENDPOINT_PORT="prometheus" \
    -p APP_LABEL=custom-amq6-broker-2 \
    | oc apply -f -

oc process -f servicemonitor-template.yaml \
    -p SERVICE_NAMESPACE=${SERVICE_NAMESPACE} \
    -p SERVICE_NAME=custom-amq6-broker-3-prometheus \
    -p ENDPOINT_PORT="prometheus" \
    -p APP_LABEL=custom-amq6-broker-3 \
    | oc apply -f -

SERVICE_NAMESPACE=fuse-int

oc process -f servicemonitor-template.yaml \
    -p SERVICE_NAMESPACE=${SERVICE_NAMESPACE} \
    -p SERVICE_NAME=consumer-app-prometheus \
    -p ENDPOINT_PORT="prometheus" \
    -p APP_LABEL=consumer-app \
    | oc apply -f -

oc process -f servicemonitor-template.yaml \
    -p SERVICE_NAMESPACE=${SERVICE_NAMESPACE} \
    -p SERVICE_NAME=producer-app-prometheus \
    -p ENDPOINT_PORT="prometheus" \
    -p APP_LABEL=producer-app \
    | oc apply -f -