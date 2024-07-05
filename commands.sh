#!/bin/bash 

# Pull Container images
docker pull vulnerables/web-dvwa
docker pull owasp/modsecurity-crs:3.3.4-nginx-alpine-202301110601@sha256:46c78b60dff1c3767782d147657ff1058f99b3e538eeb6149b1ccd76bf582a34

# Create Network
docker network create backend --subnet 10.10.10.0/24

# Build Nginx-modsec
docker build -t nginx-modsec .

# Deploy containers
docker run -it --name dvwa --hostname dvwa --network backend --ip 10.10.10.100 vulnerables/web-dvwa
docker run -it --name nginx-modsec --network backend --ip 10.10.10.200 nginx-modsec 

echo  '[+] Access Application on:  http://10.10.10.200'
