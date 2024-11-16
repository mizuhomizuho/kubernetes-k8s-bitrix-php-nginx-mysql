#!/bin/sh

if [ ! -d "/pvc/web" ]; then
  echo "Install..."
  mkdir /pvc/web
  chmod 777 /pvc/web
  unzip /k8s/business_encode.zip -d /pvc/web >> /dev/null
  cat /k8s/scripts/bitrix_server_test.php > /pvc/web/bitrix_server_test.php
  echo "End..."
fi