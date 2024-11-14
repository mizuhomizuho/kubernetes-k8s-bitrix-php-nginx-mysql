#!/bin/sh
echo 'php_bootstrap.sh...'
php -r 'copy("/var/www/app/k8s/php-bitrix.ini", "/usr/local/etc/php/conf.d/php-bitrix.ini");'
php-fpm -F -R