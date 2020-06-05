#!/bin/sh

set -e

install_clt() {
  echo 'Install CLT'
  xcode-select --install
}


install_pipx() {
  echo 'Create user venv'
  mkdir ~/.local
  python3 -m venv ~/.local/venv
  echo 'Install pipx into user venv'
  .local/venv/bin/pip install pipx
  echo 'Manually ensurepath for pipx'
  # this will be replaced later with ansible configs
  echo 'export PIPX_BIN_DIR="${PIPX_HOME:-$HOME/.local/pipx}/bin"' >> ~/.zshrc
  echo 'export PATH="$HOME/.local/venv/bin:$PATH:$HOME/.local/pipx/bin"' >> ~/.zshrc
}


ensurepath_pipx() {
  echo 'ensurepat ppix'
  pipx ensurepath
}


install_ansible() {
  echo 'Install ansible with pipx'
  pipx install ansible
}
