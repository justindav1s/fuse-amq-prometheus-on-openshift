#!/usr/bin/env bash


psql amq postgres << EOF
CREATE DATABASE amq_1 with OWNER amq;
CREATE DATABASE amq_2 with OWNER amq;
CREATE DATABASE amq_3 with OWNER amq;
\du
\l
EOF