#!/bin/sh
echo 'php_bootstrap.sh...'
/var/www/app/k8s/install-php-extensions gd
php -r 'copy("/var/www/app/k8s/php-bitrix.ini", "/usr/local/etc/php/conf.d/php-bitrix.ini");'
#php-fpm -F -R