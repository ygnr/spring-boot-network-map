#!/bin/bash

echo "starting network map service"

# start the server
echo "starting network map"
java -Djava.security.egd=file:/dev/urandom -jar /app.jar --nodesDirectoryUrl=file:///opt/corda/ &


let EXIT_CODE=255
while [ ${EXIT_CODE} -gt 0 ]
do
    sleep 2
    echo "Waiting for network map to start"
    curl -s http://localhost:8080/network-map > /dev/null
    let EXIT_CODE=$?
done

echo "starting notary"
java -jar /opt/corda/corda.jar --base-directory=/opt/corda