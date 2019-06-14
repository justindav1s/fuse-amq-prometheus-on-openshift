#!/bin/bash

PROMETHEUS_NAMESPACE=amq
PROMETHEUS_SA='prometheus'
graph_granularity=''
yaml='grafana.yaml'
PROTOCOL="http://"

oc project ${PROMETHEUS_NAMESPACE}
oc process -f grafana.yaml \
    -p NAMESPACE=${PROMETHEUS_NAMESPACE} \
    -p ROUTE_URL="grafana-amq.apps.ocp.datr.eu" \
    | oc create -f -

oc rollout status deployment/grafana

oc adm policy add-role-to-user view -z grafana -n ${PROMETHEUS_NAMESPACE}

payload="$( mktemp )"
cat <<EOF >"${payload}"
{
"name": "FUSE-PROMETHEUS",
"type": "prometheus",
"typeLogoUrl": "",
"access": "proxy",
"url": "${PROTOCOL}$( oc get route prometheus -n "${PROMETHEUS_NAMESPACE}" -o jsonpath='{.spec.host}' )",
"basicAuth": false,
"withCredentials": false,
"jsonData": {
    "tlsSkipVerify":true,
    "httpHeaderName1":"Authorization"
},
"secureJsonData": {
    "httpHeaderValue1":"Bearer $( oc sa get-token "${PROMETHEUS_SA}" -n "${PROMETHEUS_NAMESPACE}" )"
}
}
EOF

# setup grafana data source
GRAFANA_HOST="${protocol}$( oc get route grafana -o jsonpath='{.spec.host}' )"
curl --insecure -H "Content-Type: application/json" -u admin:admin "${GRAFANA_HOST}/api/datasources" -X POST -d "@${payload}"

