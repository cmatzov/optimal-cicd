#!/bin/bash

ssh optimal@192.168.66.11 "bash -s" << EOF
#!/bin/bash

containers=\$(lxc list --format csv --columns=n | grep opt-tst)

sudo rm -rf /automations/backups/*

ikea_backup=\$(ls -1t /var/backups/ikea/*.tar | head -n 1)
verila_backup=\$(ls -1t /var/backups/verila/*.tar | head -n 1)

sudo cp \$ikea_backup /automations/backups/
sudo cp \$verila_backup /automations/backups/

for container in \$containers; do
    lxc start \$container
    sleep 30

    lxc exec \$container -- /bin/bash << EOL
    docker exec -i optimal-novus_postgresql_1 pg_restore -h localhost -U postgres -d ikea < /root/ikea*.tar
    docker exec -i optimal-novus_postgresql_1 pg_restore -h localhost -U postgres -d verila < /root/verila*.tar

EOL

    lxc stop \$container

    lxc delete \$container_name/base-snap-test

    lxc snapshot \$container_name base-snap-test

done
EOF