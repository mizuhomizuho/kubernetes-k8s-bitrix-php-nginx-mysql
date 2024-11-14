PHP_SPLIT = preg_split('/\s+/', trim(file_get_contents('php://stdin')))
PODS_TO_PHP = kubectl get pods | grep "$(type)-[0-9a-z]*-[0-9a-z]*" | sed "s@\s.*@\ @" | php -r
PODS_BY_NUM = $(shell ${PODS_TO_PHP} "echo $(PHP_SPLIT)[$(num)];")
APPLY = kubectl apply -f "$(CURDIR)/k8s/bitrix-deployment.yaml"

.PHONY: up
up:
	@minikube start --mount --mount-string="$(CURDIR):/src/app-volume" --addons=ingress

.PHONY: apply
apply:
	@${APPLY}

.PHONY: refresh
refresh:
	@${APPLY}
	@minikube stop
	@minikube start

.PHONY: exec
exec:
	kubectl exec -it $(PODS_BY_NUM) -- sh

.PHONY: logs
logs:
	@${PODS_TO_PHP} \
 	"foreach ($(PHP_SPLIT) as $$podId) \
		echo \
		$$podId . ' $(lp) (begin):' . PHP_EOL . \
		shell_exec('kubectl logs ' . $$podId . ' $(lp)') . \
		$$podId . ' $(lp) (end).' . PHP_EOL;"

