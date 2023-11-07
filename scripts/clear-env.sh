#!/bin/bash

# Usage script.sh $container_name

container_name=$1

ssh optimal@192.168.66.11 "bash -s" << EOF

#!/bin/bash

lxc stop $container_name

lxc restore $container_name base-snap-test

EOF