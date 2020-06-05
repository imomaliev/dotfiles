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
   echo 'localhost ansible_connection=local ansible_python_interpreter="~/.local/share/pipx/venvs/ansible/bin/python3"' > inventory
   ```
1. Run playbook
   ```console
   ansible-playbook -v -i inventory site.yml
   ```
