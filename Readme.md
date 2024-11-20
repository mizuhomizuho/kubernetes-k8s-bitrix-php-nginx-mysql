# KUBERNETES (K8S) BITRIX PHP NGINX MYSQLU

```text
Ingress:
------------------------------------------------------------------------------------------------------------
NAME             CLASS   HOSTS          ADDRESS        PORTS   AGE
bitrix-ingress   nginx   bitrix.local   192.168.49.2   80      105s
------------------------------------------------------------------------------------------------------------
Services:
------------------------------------------------------------------------------------------------------------
NAME         TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)    AGE    SELECTOR
kubernetes   ClusterIP   10.96.0.1       <none>        443/TCP    77m    <none>
mysql        ClusterIP   10.101.83.25    <none>        3306/TCP   108s   app=mysql
nginx        ClusterIP   10.100.87.112   <none>        80/TCP     108s   app=nginx
php          ClusterIP   10.106.127.85   <none>        9000/TCP   108s   app=php
------------------------------------------------------------------------------------------------------------
Pods:
------------------------------------------------------------------------------------------------------------
NAME                     READY   STATUS    RESTARTS   AGE    IP            NODE       NOMINATED NODE   READINESS GATES
mysql-54494656bd-688c9   1/1     Running   0          111s   10.244.0.13   minikube   <none>           <none>
nginx-8557b4d69b-4mbzs   1/1     Running   0          110s   10.244.0.11   minikube   <none>           <none>
php-69df69dbfb-pjnlp     1/1     Running   0          111s   10.244.0.12   minikube   <none>           <none>
------------------------------------------------------------------------------------------------------------
Pvc:
------------------------------------------------------------------------------------------------------------
NAME        STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   VOLUMEATTRIBUTESCLASS   AGE    VOLUMEMODE
app-pvc     Bound    pvc-fa8b2fa8-092f-488f-ad29-ba3df4351949   8Gi        RWX            standard       <unset>                 114s   Filesystem
mysql-pvc   Bound    pvc-b032affe-9e50-41ba-992e-e32b34a8a2b4   8Gi        RWO            standard       <unset>                 114s   Filesystem
```

## You're gonna need:

- docker
- minikube
- kubectl

## Current version:

- Bitrix 24.0.796
- PHP 8.1
- MySQL 8

## Data:

- Url http://bitrix.local
- Mysql root password "meow88888888"
- Mysql host "mysql.default.svc.cluster.local"
- Mysql user "sitemanager"
- Mysql passowrd "sitemanager"
- Mysql db "sitemanager"
- Ssh password "root123"
- ssh -p 8822 root@127.0.0.1
- http://bitrix.local/adminer-4.8.1.php

## For start:

```shell
wget -O ./k8s/business_encode.tar.gz https://www.1c-bitrix.ru/download/business_encode.tar.gz
```
```shell
docker build -t k8s_bitrix_php ./k8s
```
```shell
make restart
```
```shell
minikube image load k8s_bitrix_php
```
```shell
make apply
```
```shell
make -j 2 tunnel type=php num=0
```

## More command examples:

```shell
make info
```
```shell
make delete
```
```shell
make exec type=mysql num=0
```
```shell
make logs type=php
```
```shell
make del-pod type=nginx num=0
```
