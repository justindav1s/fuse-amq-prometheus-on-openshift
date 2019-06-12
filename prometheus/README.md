# Deploying Prometheus

All templates used here are based templates found here :
   * https://github.com/jboss-fuse/application-templates/tree/application-templates-2.1.fuse-730065-redhat-00002



1. run [deploy-crds.sh](deploy-crds.sh) if your cluster has never had the prometheus operator deployed to it.
2. decide whether you want to deploy prometheus with cluster privileges or not.
    * YES : edit and then run [deploy-prometheus-cluster.sh](deploy-prometheus-cluster.sh), after providing namespaces and service names that need to be monitored.
    * NO : edit and then run [deploy-prometheus-namespaces.sh](deploy-prometheus-namespaces.sh), after providing namespaces and service names that need to be monitored. This script will also setup Roles and Rolebindings for prometheus in monitorable namespaces.
