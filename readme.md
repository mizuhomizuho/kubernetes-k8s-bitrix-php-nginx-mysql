# kubernetes (k8s) bitrix php nginx mysql

```shell
minikube delete
```
```shell
make up
```
```shell
make apply
```
```shell
make refresh
```
```shell
kubectl get pods -o wide
```
```shell
minikube tunnel
```
```shell
make exec type=nginx num=0
```
```shell
make exec type=php num=0
```
```shell
make logs type=php
```
```shell
make logs type=php lp="-c php-init"
```