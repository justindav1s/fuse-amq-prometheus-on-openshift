#!/usr/bin/env bash


HOST=ocp.datr.eu
USER=justin
PROJECT=amq74
APPLICATION_NAME=broker

oc login https://${HOST}:8443 -u $USER

oc delete project $PROJECT
oc new-project $PROJECT 2> /dev/null
while [ $? \> 0 ]; do
    sleep 1
    printf "."
oc new-project $PROJECT 2> /dev/null
done

oc project $PROJECT

echo '{"kind": "ServiceAccount", "apiVersion": "v1", "metadata": {"name": "amq-service-account"}}' | oc create -f -
oc policy add-role-to-user view system:serviceaccount:amq-demo:amq-service-account
oc create secret generic amq-app-secret --from-file=broker.ks
oc secrets add sa/amq-service-account secret/amq-app-secret


oc new-app -f amq-broker-74-persistence-clustered-ssl.yaml \
   -p APPLICATION_NAME=broker \
   -p AMQ_PROTOCOL='openwire,amqp,stomp,mqtt,hornetq' \
   -p AMQ_QUEUES='' \
   -p AMQ_ADDRESSES='' \
   -p VOLUME_CAPACITY=1Gi \
   -p AMQ_USER='admin' \
   -p AMQ_PASSWORD='changeme' \
   -p AMQ_ROLE='admin' \
   -p AMQ_NAME='broker' \
   -p AMQ_CLUSTERED='true' \
   -p AMQ_REPLICAS='3' \
   -p AMQ_CLUSTER_USER='clusteruser' \
   -p AMQ_CLUSTER_PASSWORD='changeme' \
   -p AMQ_GLOBAL_MAX_SIZE='10 gb' \
   -p AMQ_REQUIRE_LOGIN='true' \
   -p AMQ_SECRET='amq-app-secret' \
   -p AMQ_TRUSTSTORE='broker.ts' \
   -p AMQ_TRUSTSTORE_PASSWORD='changeme' \
   -p AMQ_KEYSTORE='broker.ks' \
   -p AMQ_KEYSTORE_PASSWORD='changeme' \
   -p AMQ_DATA_DIR='/opt/amq/data' \
   -p AMQ_DATA_DIR_LOGGING='true' \
   -p AMQ_EXTRA_ARGS='' \
   -p AMQ_ANYCAST_PREFIX='' \
   -p AMQ_MULTICAST_PREFIX='' \
   -p IMAGE=docker-registry.default.svc:5000/openshift/amq-broker:7.4
