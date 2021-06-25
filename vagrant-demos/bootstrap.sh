#!/usr/bin/env bash

#Set URL and version
export VAULT_URL="https://releases.hashicorp.com/vault" VAULT_VERSION="1.7.2+ent"

#Download Vault
curl \
    --silent \
    --remote-name \
   "${VAULT_URL}/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip"

#Unzip
sudo apt-get install -y unzip
unzip vault_${VAULT_VERSION}_linux_amd64.zip
#Install jq
sudo apt install -y jq
#Install MySQL
sudo apt install -y mysql-server
#Setup root password for mysql
sudo mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH caching_sha2_password BY 'R00tPassword';"
#Owner of Binary
sudo chown root:root vault
#Set system path
sudo mv vault /usr/local/bin/
#Set profile
cat ./profile.txt >> .bashrc
#Remove .zip
rm -rf vault_${VAULT_VERSION}_linux_amd64.zip