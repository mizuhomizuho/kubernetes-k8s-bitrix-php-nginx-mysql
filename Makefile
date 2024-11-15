PHP_SPLIT = preg_split('/\s+/', trim(file_get_contents('php://stdin')))
PODS_TO_PHP = kubectl get pods | grep "$(type)-[0-9a-z]*-[0-9a-z]*" | sed "s@\s.*@\ @" | php -r
PODS_BY_NUM = $(shell ${PODS_TO_PHP} "echo $(PHP_SPLIT)[$(num)];")
MAIN_YAML = "$(CURDIR)/k8s/main.yaml"

.PHONY: restart
restart:
	-@minikube stop
	@minikube start --mount --mount-string="$(CURDIR):/app" --addons=ingress

.PHONY: apply
apply:
	@kubectl apply -f $(MAIN_YAML)

.PHONY: delete
delete:
	-@kubectl delete -f $(MAIN_YAML)

.PHONY: exec
exec:
	kubectl exec -it $(PODS_BY_NUM) -- sh

.PHONY: info
info:
	@minikube ip
	-@kubectl get pods -o wide
	-@kubectl get pvc

.PHONY: logs
logs:
	@${PODS_TO_PHP} \
 	"foreach ($(PHP_SPLIT) as $$podId) \
		echo \
		$$podId . ' $(lp) (begin):' . PHP_EOL . \
		shell_exec('kubectl logs ' . $$podId . ' $(lp)') . \
		$$podId . ' $(lp) (end).' . PHP_EOL;"

