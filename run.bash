#!/usr/bin/env bash

# All time use vault
# if [[ $VAULT -eq 1 ]];then
# PARAMS="--vault-password-file /serv/secret/vault_pass.txt"
# fi

source ./ansible/hacking/env-setup -q

if [[ -f /serv/secret/vault_pass.txt ]];then
 PARAMS="--vault-password-file /serv/secret/vault_pass.txt"
else
 PARAMS="--vault-password-file .vault_pass.txt"
fi

USER=$(whoami)
PARAMS="$PARAMS --private-key=~/.ssh/id_rsa --user=$USER"

if [[ $CHECK -eq 1 ]];then
  PARAMS="$PARAMS --check --diff"
fi

if [[ -n $LIMIT ]];then
  PARAMS="$PARAMS --limit=$LIMIT"
fi

ansible-playbook --inventory=environments/$ENVIRONMENT playbooks/$PLAY.yml $PARAMS
