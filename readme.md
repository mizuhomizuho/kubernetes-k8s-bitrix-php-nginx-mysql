# kubernetes (k8s) bitrix php nginx mysql

## [Ответы на вопросы](https://github.com/mizuhomizuho/kubernetes-k8s-bitrix-php-nginx-mysql/blob/master/Result.odt)

```shell
curl -o ./k8s https://www.1c-bitrix.ru/download/business_encode.zip
ssh -p 51348 -i ~/.minikube/machines/minikube/id_rsa docker@127.0.0.1
```
```shell
docker build -t php81fpm-k8s-bitrix ./k8s
```
```shell
make restart
```
```shell
make restart-dev
```
```shell
minikube image load php81fpm-k8s-bitrix
```
```shell
make apply
```
```shell
make delete
```
```shell
make info
```
```shell
minikube tunnel
```
```shell
make exec type=php num=0
```
```shell
make exec type=nginx num=0
```
```shell
make exec type=mysql num=0
```
```shell
make logs type=php
```
```shell
make logs type=nginx
```
```shell
make logs type=mysql
```
```shell
make logs type=php lp="-c php-init"
```
```shell
make delpod type=php num=0
```
```shell
make delpod type=nginx num=0
```
```shell
make delpod type=mysql num=0
```