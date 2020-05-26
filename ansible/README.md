# Ansible setup
## Ensure inventory
1. echo "myhost" > ansible/hosts
1. ansible-playbook -v -i ansible/hosts ansible/site.yml

## Run localy
```
echo "myhost ansible_connection=local" >> ansible/hosts
```
