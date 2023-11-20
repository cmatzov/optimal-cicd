#!/bin/bash

ssh optimal@192.168.66.11 "bash -s" << 'EOF'
#!/bin/bash

containers=$(lxc list --format csv --columns=n | grep opt-tst)

for container in $containers; do
    status=$(lxc info $container | grep "Status" | awk '{print $2}')
    if [ "$status" == "RUNNING" ]; then
    
        lxc stop $container
        sleep 5
        
    fi

    lxc restore $container base-snap-test

done
EOF