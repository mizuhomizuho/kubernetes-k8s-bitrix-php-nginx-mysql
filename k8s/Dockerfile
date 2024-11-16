FROM php:8.1-fpm

COPY scripts/install-php-extensions /install-php-extensions

RUN /install-php-extensions gd mysqli \
    && apt-get update \
    && apt-get install -y openssh-server \
    && mkdir /var/run/sshd \
    && echo 'root:root123' | chpasswd \
    && sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
