#!/usr/bin/env bash

# Mount generic backends and write some secrets
vault secrets enable  -path=supersecret -version=2 kv

# Single KVs
vault kv  put  supersecret/admin my_password=hope_no_one_finds_out

# Multiple KVs
#vault kv  put  supersecret/admin admin_user=root admin_password=P@55w3rd

# Show KVs
vault kv get  supersecret/admin

#Show specific KV
#vault kv get -field=admin_user supersecret/admin

#Create another version
vault kv  put  supersecret/admin my_password=Im_sure_no_one_finds_out

#Username does not exists
#vault kv get  supersecret/admin

#Use patch to include also admin_user instead of creating another version
#vault kv patch  supersecret/admin admin_user=root

#Show KVs - different versions
vault kv get  supersecret/admin
vault kv get  -version=1 supersecret/admin
vault kv get  -version=2 supersecret/admin

#Rollback to previous or specific version
vault kv rollback  -version=1 supersecret/admin
vault kv get  supersecret/admin

#Rollback to version 2
vault kv rollback  -version=2 supersecret/admin
vault kv get  supersecret/admin
----------------------------------------------------------------






#List secrets / Keys under supersecret
vault kv list supersecret

curl --header "X-Vault-Token: root" --request POST \
--data '{"data": {"apikey": "my-api-key"} }' \
$VAULT_ADDR/v1/secret/data/apikey/google | jq

--------
# Normal servers have version 1 of KV mounted by default, so will need these
# paths:
echo '
path "sys/mounts" {
  capabilities = ["list","read"]
}
path "secret/*" {
  capabilities = ["create"]
}
path "secret/foo" {
  capabilities = ["read"]
}
# Dev servers have version 2 of KV mounted by default, so will need these
# paths:
path "supersecret/*" {
  capabilities = ["list","create","read"]
}
path "supersecret/data/*" {
  capabilities = ["list","create","read"]
}
path "supersecret/data/admin" {
  capabilities = ["list"]
} ' | vault policy write user -


--------

# Disable generic backends
vault secrets disable supersecret

-------------------

##PATH-HELP
vault path-help secret

vault path-help sys

vault path-help sys/auth
