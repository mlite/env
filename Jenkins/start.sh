#!/bin/bash

# --prefix=/jenkins is needed
# for reverse proxy /jenkins
# to this host
docker run --restart=always \
       --name stensal_jenkins \
       -p 8080:8080 \
       -p 50000:5000 \
       -v jenkins_home:/var/jenkins_home \
       --env JENKINS_OPTS="--prefix=/jenkins" \
       jenkins/jenkins:lts
