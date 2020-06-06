# Dotfiles

## macOS
Currently for macOS Catalina

### Pre install

1. Run install script
   ```console
   ./install.sh
   ```

### Run ansible playbook

1. Ensure inventory
1. ```console
   echo 'localhost ansible_connection=local' > inventory
   ```
1. Run playbook
   ```console
   ansible-playbook -v -i inventory site.yml
   ```
1. Remove .ansible folder
   ```console
   rm -r ~/.ansible
   ```
