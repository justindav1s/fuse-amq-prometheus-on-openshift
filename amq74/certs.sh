#!/usr/bin/env bash

#!/usr/bin/env bash

PASSWORD=changeme

rm -rf  *.ks *.ts *_cert

# Generate a self-signed certificate for the broker keystore:
keytool -genkey -alias broker -keyalg RSA -keystore broker.ks -storepass ${PASSWORD}

# Export the certificate so that it can be shared with clients:
keytool -export -alias broker -keystore broker.ks -file broker_cert -storepass ${PASSWORD}

# Generate a self-signed certificate for the client keystore:
keytool -genkey -alias client -keyalg RSA -keystore client.ks -storepass ${PASSWORD}

# Create a client truststore that imports the broker certificate:
keytool -import -alias broker -keystore client.ts -file broker_cert -storepass ${PASSWORD}

# Export the client’s certificate from the keystore:
keytool -export -alias client -keystore client.ks -file client_cert -storepass ${PASSWORD}

# Import the client’s exported certificate into a broker SERVER truststore:
keytool -import -alias client -keystore broker.ts -file client_cert -storepass ${PASSWORD}

cp broker.ks broker.ts ..