#!/bin/sh
#/k8s/test.sh
echo "---------------------------------------------------"
##cat /etc/hosts_bu > /etc/hosts
#NGINX_IP="$(getent hosts "nginx.default.svc.cluster.local" | sed "s@\s.*@\ @")"
##cat /etc/hosts_bu | sed "s/127\.0\.0\.1\slocalhost/${NGINX_IP}localhost\n${NGINX_IP}bitrix.local/"  > /etc/hosts
##cat /etc/hosts
#echo ${NGINX_IP}
#
#while true; do
#  if [ ${NGINX_IP} != "" ]; then
#    break
#  fi
#  sleep 0.5
#done