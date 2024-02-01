# #!/bin/bash

# ssh -i /root/.ssh/id_rsa optimal@192.168.66.11 "bash -s" << 'EOF'
# #!/bin/bash

# containers=$(lxc list --format csv --columns=n | grep opt-)

# sudo rm -rf /automations/backups/*

# ikea_backup=$(ls -1t /var/backups/ikea/*.tar | head -n 1)
# verila_backup=$(ls -1t /var/backups/verila/*.tar | head -n 1)

# sudo cp $ikea_backup /automations/backups/
# sudo cp $verila_backup /automations/backups/

# for container in $containers; do

#     status=$(lxc info $container | grep "Status" | awk '{print $2}')
#     if [ "$status" == "RUNNING" ]; then
#         echo "container is already running, skipping"
#     else
#         lxc start $container
#     fi
#     while true; do
#       if lxc info $container | grep docker0; then
#         echo "Restoring the database, just a minute..."
#         lxc exec $container -- bash -c '
#             docker exec -i optimal-novus_postgresql_1 pg_restore -h localhost -U postgres -d ikea < /root/ikea*.tar
#             docker exec -i optimal-novus_postgresql_1 pg_restore -h localhost -U postgres -d verila < /root/verila*.tar
#         '
#         break
#       else
#         echo "Waiting for the container to start. Retrying in 5 seconds..."
#         sleep 5
#       fi
#     done
# done
# EOF

#!/bin/bash

ssh -i /root/.ssh/id_rsa optimal@192.168.66.11 "bash -s" << 'EOF'
#!/bin/bash


clear_test_env_scheduled () {
  local containers=$(lxc list --format csv --columns=n | grep opt-tst)
  local status=$(lxc info $container | grep "Status" | awk '{print $2}')
  
  for container in $containers; do

    if [ "$status" == "RUNNING" ]; then
    
        lxc stop $container
        sleep 15
        
    fi

    lxc restore $container base-snap-test
}


start_all_containers () {
  local container="$1"
  local status=$(lxc info "$container" | grep "Status" | awk '{print $2}')

  if [ "$status" == "RUNNING" ]; then
      echo "container is already running, skipping"
  else
      lxc start $container
  fi
}


wait_for_the_daemon_to_start () {
  local container="$1"

  while true; do
  if lxc info $container | grep docker0; then
    echo "Ready to deploy, just a minute..."
    break
  else
    echo "Waiting for the container to start. Retrying in 5 seconds..."
    sleep 5
  fi
  done

}


restore_latest_database () {
  local container="$1"

  echo "Restoring the databases for '$container'. Please wait..."

  lxc exec "$container" -- bash -c "
    docker exec -i optimal-novus-postgresql_1 pg_restore -h localhost -U postgres -d ikea < /root/ikea*.tar
    docker exec -i optimal-novus-postgresql_1 pg_restore -h localhost -U postgres -d verila < /root/verila*.tar
  "
}


stop_and_snapshot () {
  local $container="$1"

  lxc stop $container

  lxc delete $container/base-snap-test

  lxc snapshot $container base-snap-test

}


clear_test_env_scheduled

sudo rm -rf /automations/backups/*

ikea_backup=$(ls -1t /var/backups/ikea/*.tar | head -n 1)
verila_backup=$(ls -1t /var/backups/verila/*.tar | head -n 1)

sudo cp $ikea_backup /automations/backups/
sudo cp $verila_backup /automations/backups/

containers=$(lxc list --format csv --columns=n | grep opt-)

for container in $containers; do

  start_all_containers "$container"

  wait_for_the_daemon_to_start "$container"

  restore_latest_database "$container"

  stop_and_snapshot "$container"

done

EOF