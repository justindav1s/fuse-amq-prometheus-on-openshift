#!/usr/bin/env bash

# run the makesecrets.sh script first, remember the password you used, and update it here

HOST=ocp.datr.eu
USER=justin
PROJECT=amq7
APPLICATION_NAME=broker

#oc login https://${HOST}:8443 -u $USER
#
#oc delete project $PROJECT
#oc adm new-project $PROJECT 2> /dev/null
#while [ $? \> 0 ]; do
#    sleep 1
#    printf "."
#oc adm new-project $PROJECT 2> /dev/null
#done

oc project $PROJECT

oc delete statefulset broker-amq
oc delete route console-jolokia
oc delete svc broker-amq-headless
oc delete svc ping
oc delete serviceaccounts broker-service-account
oc delete serviceaccounts ${APPLICATION_NAME}-service-account
oc delete role broker-role
oc delete rolebinding broker-role-binding
oc delete secret broker-secret-config


echo '{"kind": "ServiceAccount", "apiVersion": "v1", "metadata": {"name": "amq-service-account"}}' | oc create -f -

oc policy add-role-to-user view system:serviceaccount:${PROJECT}:${APPLICATION_NAME}-service-account

oc create secret generic ${APPLICATION_NAME}-secret-config \
    --from-file=broker.xml=config/broker.xml

sleep 2

oc new-app -f ../../templates/amq73-persistence-clustered.yaml \
    -p APPLICATION_NAME=${APPLICATION_NAME} \
    -p AMQ_PROTOCOL=openwire,amqp,stomp,mqtt,hornetq \
    -p AMQ_QUEUES=demoQueue \
    -p AMQ_ADDRESSES= \
    -p VOLUME_CAPACITY=1Gi \
    -p AMQ_USER=admin \
    -p AMQ_PASSWORD=changeme \
    -p AMQ_ROLE=admin \
    -p AMQ_NAME=broker \
    -p AMQ_CLUSTERED=true \
    -p AMQ_REPLICAS=3 \
    -p AMQ_CLUSTER_USER=cluster_user \
    -p AMQ_CLUSTER_PASSWORD=changeme \
    -p AMQ_GLOBAL_MAX_SIZE="1 gb" \
    -p AMQ_REQUIRE_LOGIN=true \
    -p AMQ_DATA_DIR=/opt/amq/data \
    -p AMQ_DATA_DIR_LOGGING=true \
    -p AMQ_EXTRA_ARGS= \
    -p AMQ_ANYCAST_PREFIX= \
    -p AMQ_MULTICAST_PREFIX= \
    -p AMQ_SECRET_CONFIG_DIR="/opt/amq/etc/configmap" \
    -p IMAGE=docker-registry.default.svc:5000/$PROJECT/custom-amq7:latest


oc new-app -f ../../templates/amq7-console-route.yaml \
    -p PROJECT=${PROJECT}


