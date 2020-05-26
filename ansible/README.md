# Ansible setup
## Ensure inventory
1. echo "myhost" > ansible/hosts
1. ansible-playbook -v -i ansible/hosts ansible/site.yml

## Run localy
Fix issue with https://github.com/ansible/ansible/issues/57542
```
echo "myhost ansible_connection=local ansible_python_interpreter="/usr/bin/python3"
" >> ansible/hosts
```
