#!/usr/bin/env bash

# Mount generic backends and write some secrets
vault secrets enable  -path=supersecret -version=2 kv

# Single KVs
vault kv  put  supersecret/admin my_password=hope_no_one_finds_out

# Multiple KVs
#vault kv  put  supersecret/admin admin_user=root admin_password=P@55w3rd

# Show KVs
#vault kv get  supersecret/admin

#Show specific KV
#vault kv get -field=admin_user supersecret/admin

#Create another version
vault kv  put  supersecret/admin my_password=Im_sure_no_one_finds_out
#Create yet another version :)
vault kv  put  supersecret/admin my_password=Okay_its_safe!

#Username does not exists
#vault kv get  supersecret/admin

#Use patch to include also admin_user instead of creating another version
#vault kv patch  supersecret/admin admin_user=root

#Show KVs - different versions
vault kv get  supersecret/admin
vault kv get  -version=1 supersecret/admin
vault kv get  -version=3 supersecret/admin
vault kv get  -version=2 supersecret/admin

#End
# ----------------------------------------------------------------

#Rollback to previous or specific version
#vault kv rollback  -version=1 supersecret/admin
#vault kv get  supersecret/admin

#Rollback to version 2
#vault kv rollback  -version=3 supersecret/admin
#vault kv get  supersecret/admin
# Demo End
# ----------------------------------------------------------------
#Argument for namespace: -namespace=DBAs
