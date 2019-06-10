# Fuse and AMQ6

## Repository Contents
   * [bin/amq6](bin/amq6) : scripts to build and deploy an active-active-active AMQ6 broker mesh based on a custom image, with the following characteristics :
      * Postgresql JDBC driver on board
      * Prometheus Node Exporter for Broker JMX metrics
      * Broker configuration mounted as a secrets volume

   * [bin/fuse](bin/fuse) : scripts to build and deploy two toy Fuse Spring-boot microservices that produce and consume messages to and from the AMQ6 mesh

   * [fuse/consumer-app](fuse/consumer-app) : source code for a Fuse route for AMQ message consumption, deployed with Spring-boot

   * [fuse/producer-app](fuse/producer-app) : source code for a Fuse route for AMQ message production, deployed with Spring-boot

# Supported Configs

https://access.redhat.com/articles/310613

# Broker Networks

https://access.redhat.com/documentation/en-us/red_hat_jboss_a-mq/6.3/html/fault_tolerant_messaging/fmqfaulttolnetwork

https://access.redhat.com/documentation/en-us/red_hat_jboss_a-mq/6.3/html/using_networks_of_brokers/index
https://access.redhat.com/documentation/en-us/red_hat_jboss_a-mq/6.3/html/managing_and_monitoring_a_broker/mq-topol#MQ-Topol-BrokerNetworks

# Openshift

https://access.redhat.com/documentation/en-us/red_hat_jboss_a-mq/6.3/html-single/red_hat_jboss_a-mq_for_openshift/index

# With Prometheus

https://blog.openshift.com/enhanced-openshift-jboss-amq-container-image-for-production/

#Base Image

https://access.redhat.com/containers/?tab=overview#/registry.access.redhat.com/jboss-amq-6/amq63-openshift

# Based on this

https://github.com/lbroudoux/openshift-cases
https://github.com/yohanesws/amq63-mariadb-ocp

https://blog.joshdreagan.com/2017/03/25/scaling_jboss_a-mq_on_openshift/


### Create extr databases on postgresql

1. remote shell onto postgresql pod
2. psql amq postgres
3. CREATE DATABASE amq_1 with OWNER amq;
3. CREATE DATABASE amq_2 with OWNER amq;
3. CREATE DATABASE amq_3 with OWNER amq;

