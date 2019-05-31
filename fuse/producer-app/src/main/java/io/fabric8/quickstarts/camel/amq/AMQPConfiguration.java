package io.fabric8.quickstarts.camel.amq;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

/**
 * Configuration parameters filled in from application.properties and overridden using env variables on Openshift.
 */
@Configuration
@ConfigurationProperties(prefix = "amqp")
public class AMQPConfiguration {

    private Log log = LogFactory.getLog(AMQPConfiguration.class);

    /**
     * AMQ service host
     */
    private String host;

    /**
     * AMQ service port
     */
    private Integer port;

    /**
     * AMQ username
     */
    private String username;

    /**
     * AMQ password
     */
    private String password;

    public String getConnection_string() {
        return connection_string;
    }

    public void setConnection_string(String connection_string) {
        log.info("connection_string : "+connection_string);
        this.connection_string = connection_string;
    }

    private String connection_string;

    public AMQPConfiguration() {
    }

    public String getHost() {
        return host;
    }

    public void setHost(String host) {
        log.info("host : "+host);
        this.host = host;
    }

    public Integer getPort() {
        return port;
    }

    public void setPort(Integer port) {
        log.info("port : "+port);
        this.port = port;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        log.info("username : "+username);
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        log.info("password : "+port);
        this.password = password;
    }

}
