PHP_SPLIT = preg_split('/\s+/', trim(file_get_contents('php://stdin')))
PODS_TO_PHP = kubectl get pods | grep "$(type)-[0-9a-z]*-[0-9a-z]*" | sed "s@\s.*@\ @" | php -r
PODS_BY_NUM = $(shell ${PODS_TO_PHP} "echo $(PHP_SPLIT)[$(num)];")

DEPLOYMENT_YAML = "$(CURDIR)/k8s/yams/deployment.yaml"
CONFIG_YAML = "$(CURDIR)/k8s/yams/config.yaml"
NETWORK_YAML = "$(CURDIR)/k8s/yams/network.yaml"
PVC_YAML = "$(CURDIR)/k8s/yams/pvc.yaml"

.PHONY: restart
restart:
	-@minikube stop
	@minikube start --mount --mount-string="$(CURDIR)/k8s:/k8s" --addons=ingress

.PHONY: apply
apply:
	@kubectl apply -f $(PVC_YAML)
	@kubectl apply -f $(CONFIG_YAML)
	@kubectl apply -f $(DEPLOYMENT_YAML)
	@kubectl apply -f $(NETWORK_YAML)

.PHONY: delete
delete:
	@kubectl apply -f $(NETWORK_YAML)
	@kubectl apply -f $(DEPLOYMENT_YAML)
	@kubectl apply -f $(CONFIG_YAML)

.PHONY: exec
exec:
	kubectl exec -it $(PODS_BY_NUM) -- sh

.PHONY: tunnel_1
tunnel_1:
	minikube tunnel

.PHONY: tunnel_2
tunnel_2:
	kubectl port-forward pod/$(PODS_BY_NUM) 8822:22

.PHONY: tunnel
tunnel: tunnel_1 tunnel_2

.PHONY: del-pod
del-pod:
	kubectl delete pod $(PODS_BY_NUM)

.PHONY: info
info:
	-@echo Ingress:
	-@echo ------------------------------------------------------------------------------------------------------------
	-@kubectl get ingress
	-@echo ------------------------------------------------------------------------------------------------------------
	-@echo Services:
	-@echo ------------------------------------------------------------------------------------------------------------
	-@kubectl get services -o wide
	-@echo ------------------------------------------------------------------------------------------------------------
	-@echo Pods:
	-@echo ------------------------------------------------------------------------------------------------------------
	-@kubectl get pods -o wide
	-@echo ------------------------------------------------------------------------------------------------------------
	-@echo Pvc:
	-@echo ------------------------------------------------------------------------------------------------------------
	-@kubectl get pvc -o wide


.PHONY: logs
logs:
	@${PODS_TO_PHP} \
 	"foreach ($(PHP_SPLIT) as $$podId) \
		echo \
		$$podId . ' (begin):' . PHP_EOL . \
		shell_exec('kubectl logs ' . $$podId) . \
		$$podId . ' (end).' . PHP_EOL;"

