#FROM docker-registry.default.svc:5000/openshift/jboss-amq-63:1.3
FROM quay.io/justindav1s/custom-amq6:s2i

# Temporary switch to root
USER root

# Prometheus JMX exporter agent
RUN mkdir -p /opt/prometheus/etc \
    && curl https://repo1.maven.org/maven2/io/prometheus/jmx/jmx_prometheus_javaagent/0.16.1/jmx_prometheus_javaagent-0.16.1.jar \
        -o /opt/prometheus/jmx_prometheus_javaagent.jar
ADD ./prometheus/prometheus-config.yml /opt/prometheus/prometheus-config.yml
RUN chmod 444 /opt/prometheus/jmx_prometheus_javaagent.jar \
    && chmod 444 /opt/prometheus/prometheus-config.yml \
    && chmod 775 /opt/prometheus/etc \
    && chgrp root /opt/prometheus/etc

EXPOSE 9779

RUN curl https://jdbc.postgresql.org/download/postgresql-42.2.5.jar -o /opt/amq/lib/extra/postgresql-42.2.5.jar

COPY ./bin/launch.sh /opt/amq-custom/launch.sh
RUN chmod -R 777 /opt/amq-custom

# Override default launch.
CMD [ "/opt/amq-custom/launch.sh" ]


## S2I requires a numeric, non-0 UID. This is the UID for the jboss user in the base image
USER 185

