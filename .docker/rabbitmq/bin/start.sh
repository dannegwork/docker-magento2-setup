#!/bin/bash


if [[ -n "${RABBITMQ_USER}" && -n ${RABBITMQ_PASSWORD} ]]; then
  echo "Adding new user"
  rabbitmq-server -detached
  sleep 6

  rabbitmqctl add_user ${RABBITMQ_USER} ${RABBITMQ_PASSWORD}
  rabbitmqctl set_user_tags ${RABBITMQ_USER} administrator
  rabbitmqctl set_permissions -p / ${RABBITMQ_USER} .\* .\* .\*
  if [ -n "${RABBITMQ_VHOST}" ]; then
    echo "Setting permissions for '$RABBITMQ_USER' in '$RABBITMQ_VHOST'"
    rabbitmqctl add_vhost ${RABBITMQ_VHOST}
    rabbitmqctl set_permissions -p ${RABBITMQ_VHOST} ${RABBITMQ_USER} .\* .\* .\*
  fi
  rabbitmqctl delete_user guest
  rabbitmqctl stop
  sleep 4
fi

echo "*** User '$RABBITMQ_USER' with password '$RABBITMQ_PASSWORD' completed. ***"
echo "*** Log in your browser at port 15672 (example: http:/localhost:15672) ***"

ulimit -S -n 65536
rabbitmq-server -g "daemon off;"