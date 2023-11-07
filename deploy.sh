#!/bin/bash

container_name=$1 
PROJECT=$2 
TAG=$3

ssh optimal@192.168.66.11 "bash -s" << 'EOF'

echo $container_name 

lxc exec $container_name -- /bin/bash << EOL

docker-compose up -d server jobs scheduler PROJECT=$PROJECT ENV=TEST TAG=$TAG

EOL
EOF