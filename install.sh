#!/bin/sh

set -e

_install_clt() {
  echo 'Install CLT'
  xcode-select --install
}


_install_pipx() {
    if ! [ -x "$(command -v pipx)" ]; then
        mkdir -p "$HOME"/.local/opt
        echo 'Create user venv'
        /usr/bin/python3 -m venv "$HOME"/.local/opt/venv
        echo 'Install pipx into user venv'
        "$HOME"/.local/opt/venv/bin/pip install pipx
        echo 'Manually ensurepath for pipx'
        # this will be replaced later with ansible configs
        export PIPX_HOME="$HOME/.local/share/pipx"
        export PATH="$HOME/.local/opt/venv/bin:$PATH:$HOME/.local/bin"
        pipx ensurepath
    else
        echo 'pipx already installed'
    fi
}


_install_ansible() {
    if ! [ -x "$(command -v ansible)" ]; then
        echo 'Install ansible with pipx'
        pipx install ansible
    else
        echo 'ansible already installed'
    fi
}


_run_ansible() {
    echo 'using implicit localhost'
    ansible-playbook -v -ask-become-pass site.yml

}


run_setup() {
    _install_clt
    _install_pipx
    _install_ansible
    _run_ansible
}


run_setup
unset run_setup
