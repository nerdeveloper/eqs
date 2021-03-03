kubectl exec -it vault-0 -- vault secrets enable -path=secret kv-v2
kubectl exec -it vault-0 -- vault kv put secret/database password="admin" username="admin"
kubectl exec -it vault-0 -- vault kv get secret/database
kubectl exec -it vault-0 -- vault auth enable kubernetes
# shellcheck disable=SC2034
k8s_host="$(kubectl config view --minify | grep server | cut -f 2- -d ":" | tr -d " ")"

secret_name="$(kubectl get serviceaccount mysql -o go-template='{{ (index .secrets 0).name }}')"
# shellcheck disable=SC2034
k8s_cacert="$(kubectl config view --raw --minify --flatten -o jsonpath='{.clusters[].cluster.certificate-authority-data}' | base64 --decode)"

tr_account_token="$(kubectl get secret "${secret_name}" -o go-template='{{ .data.token }}' | base64 --decode)"

kubectl exec -i vault-0 -- vault write auth/kubernetes/config token_reviewer_jwt="${tr_account_token}" kubernetes_host="${k8s_host}" kubernetes_ca_cert="${k8s_cacert}"

kubectl exec -i vault-0 -- vault policy write mysql - <<EOH
path "secret*" {
  capabilities = ["read"]
}
EOH

kubectl exec -it vault-0 -- vault write auth/kubernetes/role/mysql \
          bound_service_account_names=mysql \
          bound_service_account_namespaces=default \
          policies=mysql \
          ttl=24h \
          token_max_ttl=42h

