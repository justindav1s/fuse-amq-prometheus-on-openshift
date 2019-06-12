#!/usr/bin/env bash


PROMETHEUS_NAMESPACE=amq
MONITORABLE_NAMESPACE=fuse-int
oc project ${PROMETHEUS_NAMESPACE}

oc delete prometheus.monitoring.coreos.com prometheus
oc delete all -l app=prometheus
oc delete servicemonitors -l app=prometheus

oc delete rolebindings.rbac.authorization.k8s.io "prometheus-operator"
oc delete roles.rbac.authorization.k8s.io "prometheus-operator"
oc delete rolebindings.rbac.authorization.k8s.io "prometheus"
oc delete roles.rbac.authorization.k8s.io "prometheus"

oc delete rolebindings.rbac.authorization.k8s.io "prometheus-operator" -n ${MONITORABLE_NAMESPACE}
oc delete roles.rbac.authorization.k8s.io "prometheus-operator" -n ${MONITORABLE_NAMESPACE}
oc delete rolebindings.rbac.authorization.k8s.io "prometheus" -n ${MONITORABLE_NAMESPACE}
oc delete roles.rbac.authorization.k8s.io "prometheus" -n ${MONITORABLE_NAMESPACE}

oc delete serviceaccounts "prometheus-operator"
oc delete serviceaccount prometheus