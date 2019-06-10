# Docs

https://access.redhat.com/documentation/en-us/red_hat_fuse/7.3/html/managing_fuse/accessing_prometheus

# Templates

https://github.com/jboss-fuse/application-templates/tree/application-templates-2.1.fuse-730065-redhat-00002

## Installation

1.

oc create -f {$templates-base-url}\fuse-prometheus-crd.yml

so :

oc create -f https://raw.githubusercontent.com/jboss-fuse/application-templates/application-templates-2.1.fuse-730065-redhat-00002/fuse-prometheus-crd.yml

2.

oc process -f {$templates-base-url}/fuse-prometheus-operator.yml -p NAMESPACE=<YOUR NAMESPACE> | oc create -f -

so :

oc process -f https://raw.githubusercontent.com/jboss-fuse/application-templates/application-templates-2.1.fuse-730065-redhat-00002//fuse-prometheus-operator.yml -p NAMESPACE=<YOUR NAMESPACE> | oc create -f -