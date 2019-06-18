#!/usr/bin/env bash

# run the makesecrets.sh script first, remember the password you used, and update it here

HOST=ocp.datr.eu
USER=justin
PROJECT=amq7

oc login https://${HOST}:8443 -u $USER

oc delete project $PROJECT
oc adm new-project $PROJECT 2> /dev/null
while [ $? \> 0 ]; do
    sleep 1
    printf "."
oc adm new-project $PROJECT 2> /dev/null
done

oc project $PROJECT

echo '{"kind": "ServiceAccount", "apiVersion": "v1", "metadata": {"name": "amq-service-account"}}' | oc create -f -

oc policy add-role-to-user view system:serviceaccount:${PROJECT}:amq-service-account

oc secrets new amq-app-secret broker.ks


oc new-app -f ../../templates/amq73-persistence-clustered.yaml \
    -p APPLICATION_NAME=broker \
    -p AMQ_PROTOCOL=openwire,amqp,stomp,mqtt,hornetq \
    -p AMQ_QUEUES=demoQueue \
    -p AMQ_ADDRESSES= \
    -p VOLUME_CAPACITY=1Gi \
    -p AMQ_USER=admin \
    -p AMQ_PASSWORD=changeme \
    -p AMQ_ROLE=admin \
    -p AMQ_NAME=broker \
    -p AMQ_CLUSTERED=true \
    -p AMQ_REPLICAS=2 \
    -p AMQ_CLUSTER_USER=cluster_user \
    -p AMQ_CLUSTER_PASSWORD=changeme \
    -p AMQ_GLOBAL_MAX_SIZE="1 gb" \
    -p AMQ_REQUIRE_LOGIN=true \
    -p AMQ_SECRET=amq-app-secret \
    -p AMQ_TRUSTSTORE=broker.ts \
    -p AMQ_TRUSTSTORE_PASSWORD=changeme \
    -p AMQ_KEYSTORE=broker.ks \
    -p AMQ_KEYSTORE_PASSWORD=changeme \
    -p AMQ_DATA_DIR=/opt/amq/data \
    -p AMQ_DATA_DIR_LOGGING=true \
    -p AMQ_EXTRA_ARGS= \
    -p AMQ_ANYCAST_PREFIX= \
    -p AMQ_MULTICAST_PREFIX= \
    -p IMAGE=registry.access.redhat.com/amq-broker-7/amq-broker-72-openshift:1.3-4

oc new-app -f ../../templates/amq7-console-route-ssl.yaml \
    -p PROJECT=${PROJECT}


