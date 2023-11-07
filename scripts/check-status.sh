#!/bin/bash

# Remote server details
SERVER="optimal@192.168.66.11"

container_check () {
    ssh $SERVER "bash -s" << 'EOF'
    #!/bin/bash
    CONTAINERS=$(lxc list --format csv --columns=n | grep opt-tst)
    for container in $CONTAINERS; do
        status=$(lxc info $container | grep "Status" | awk '{print $2}')
        if [ "$status" == "STOPPED" ]; then
            echo "$container"
            break
        fi
    done
    exit 0
EOF
}

container_check