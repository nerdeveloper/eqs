kubectl exec -it vault-0 -- vault secrets enable -path=internal kv-v2
kubectl exec -it vault-0 -- vault kv put internal/database/config username="{{ username }}" password="{{ password}}"
kubectl exec -it vault-0 -- vault kv get internal/database/config
kubectl exec -it vault-0 -- vault auth enable kubernetes
kubectl exec -it vault-0 -- vault write auth/kubernetes/config token_reviewer_jwt="$(kubectl exec -it vault-0 -- cat /var/run/secrets/kubernetes.io/serviceaccount/token)" kubernetes_host="https://$KUBERNETES_PORT_443_TCP_ADDR:443" kubernetes_ca_cert=@/var/run/secrets/kubernetes.io/serviceaccount/ca.crt

kubectl exec -it vault-0 -- vault policy write internal-app - <<EOH
path "internal/data/database/config" {
  capabilities = ["read"]
}
EOH

kubectl exec -it vault-0 -- vault write auth/kubernetes/role/internal-app \
          bound_service_account_names=internal-app \
          bound_service_account_namespaces=default \
          policies=internal-app \
          ttl=24h

kubectl create serviceaccount internal-app
