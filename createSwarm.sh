#!/bin/bash


docker-machine create -d virtualbox vodalys1
docker-machine create -d virtualbox vodalys2
docker-machine create -d virtualbox vodalys3

IP1=$(docker-machine ip vodalys1)
IP2=$(docker-machine ip vodalys2)
IP3=$(docker-machine ip vodalys3)


eval $(docker-machine env vodalys1)
TOKEN=$(docker run --rm swarm create)
echo $TOKEN > token

docker run -d -p 3376:3376 -t -v /var/lib/boot2docker:/certs:ro swarm manage -H 0.0.0.0:3376 --tlsverify --tlscacert=/certs/ca.pem --tlscert=/certs/server.pem --tlskey=/certs/server-key.pem token://$TOKEN


eval $(docker-machine env vodalys2)
docker run -d swarm join --addr=$IP2:2376 token://$TOKEN


eval $(docker-machine env vodalys3)
docker run -d swarm join --addr=$IP3:2376 token://$TOKEN
