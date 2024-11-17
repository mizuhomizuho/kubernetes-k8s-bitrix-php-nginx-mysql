#!/bin/sh

echo "Boot..."
date +"%Y-%m-%d %H:%M:%S"

if [ ! -d "/var/www/app/web" ]; then

  mkdir /var/www/app/web
  chmod 777 /var/www/app/web
  tar -xzf /k8s/business_encode.tar.gz -C /var/www/app/web
  chown -R www-data:www-data /var/www/app/web

  cat /k8s/scripts/adminer-4.8.1.php > /var/www/app/web/adminer-4.8.1.php

  cat /k8s/scripts/php_status.sh > /var/www/app/php_status.sh
  chmod +x /var/www/app/php_status.sh
  cat /k8s/scripts/mysql_status.sh > /var/www/app/mysql_status.sh
  chmod +x /var/www/app/mysql_status.sh

#   curl -sSLf -o /var/www/app/web/bitrix_server_test.php https://dev.1c-bitrix.ru/download/scripts/bitrix_server_test.php
fi

NGINX_IP=$(getent hosts "nginx.default.svc.cluster.local" | sed "s@\s.*@\ @")
while true; do
  if [ "${NGINX_IP}" != "" ]; then
    cat /etc/hosts > /etc/hosts_bu
    cat /etc/hosts_bu | sed -E "s/[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+\slocalhost/${NGINX_IP}localhost\n${NGINX_IP}bitrix.local/" > /etc/hosts
    break
  fi
  sleep 0.5
done

/usr/sbin/sshd -D &
php-fpm -F -R &

echo "End..."
wait
