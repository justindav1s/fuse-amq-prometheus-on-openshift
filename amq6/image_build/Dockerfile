FROM openshift/jboss-amq-63:1.4

# Prometheus JMX exporter agent
RUN mkdir -p /opt/prometheus/etc \
    && curl http://central.maven.org/maven2/io/prometheus/jmx/jmx_prometheus_javaagent/0.11.0/jmx_prometheus_javaagent-0.11.0.jar \
      -o /opt/prometheus/jmx_prometheus_javaagent.jar
ADD prometheus-config.yml /opt/prometheus/prometheus-config.yml
RUN chmod 444 /opt/prometheus/jmx_prometheus_javaagent.jar \
    && chmod 444 /opt/prometheus/prometheus-config.yml \
    && chmod 775 /opt/prometheus/etc \
    && chgrp root /opt/prometheus/etc

RUN curl https://jdbc.postgresql.org/download/postgresql-42.2.5.jar -o /opt/amq/lib/extra/postgresql-42.2.5.jar

COPY openshift-activemq-postgresql.xml /opt/amq/conf/activemq.xml



EXPOSE 9779