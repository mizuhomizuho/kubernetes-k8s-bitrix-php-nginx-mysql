#!/bin/sh

cat /k8s/php-bitrix.ini > /usr/local/etc/php/conf.d/php-bitrix.ini

NGINX_IP=$(getent hosts "nginx.default.svc.cluster.local" | sed "s@\s.*@\ @")
while true; do
  if [ ${NGINX_IP} != "" ]; then
    cat /etc/hosts > /etc/hosts_bu
    cat /etc/hosts_bu | sed "s/127\.0\.0\.1\slocalhost/${NGINX_IP}localhost\n${NGINX_IP}bitrix.local/" > /etc/hosts
    break
  fi
  sleep 0.5
done

php-fpm -F -R