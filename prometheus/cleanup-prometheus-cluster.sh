#!/usr/bin/env bash


NAMESPACE=amq
oc project ${NAMESPACE}

oc delete prometheus.monitoring.coreos.com prometheus
oc delete all -l app=prometheus
oc delete servicemonitors -l app=prometheus
oc delete clusterrolebindings.rbac.authorization.k8s.io "prometheus-operator"
oc delete clusterroles.rbac.authorization.k8s.io "prometheus-operator"
oc delete clusterrolebindings.rbac.authorization.k8s.io "prometheus"
oc delete clusterroles.rbac.authorization.k8s.io "prometheus"
oc delete serviceaccounts "prometheus-operator"
oc delete serviceaccount prometheus