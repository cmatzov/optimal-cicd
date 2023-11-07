#!/bin/bash

ssh optimal@192.168.66.11 "bash -s" << 'EOF'
#!/bin/bash

containers=$(lxc list --format csv --columns=n | grep opt-tst)

for container in $containers; do
    
    lxc stop $container

    lxc restore $container base-snap-test

done
EOF