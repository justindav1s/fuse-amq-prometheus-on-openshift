#!/usr/bin/env bash

# run the makesecrets.sh script first, remember the password you used, and update it here

HOST=ocp.datr.eu
USER=justin
PROJECT=openshift

oc login https://${HOST}:8443 -u $USER

oc project $PROJECT

oc replace --force  -f https://raw.githubusercontent.com/jboss-container-images/jboss-amq-7-broker-openshift-image/73-7.3.0.GA/amq-broker-7-image-streams.yaml

oc import-image amq-broker-7/amq-broker-73-openshift --from=registry.redhat.io/amq-broker-7/amq-broker-73-openshift --confirm

for template in amq-broker-73-basic.yaml \
amq-broker-73-ssl.yaml \
amq-broker-73-custom.yaml \
amq-broker-73-persistence.yaml \
amq-broker-73-persistence-ssl.yaml \
amq-broker-73-persistence-clustered.yaml \
amq-broker-73-persistence-clustered-ssl.yaml;
do
 oc replace --force -f \
    https://raw.githubusercontent.com/jboss-container-images/jboss-amq-7-broker-openshift-image/73-7.3.0.GA/templates/${template}
done



