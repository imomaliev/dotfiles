#!/bin/sh

set -e

install_clt() {
  echo 'Install CLT'
  xcode-select --install
}


install_pipx() {
  echo 'Create user venv'
  XDG_DATA_DIR="${XDG_DATA_DIR:-$HOME/.local/share}"
  mkdir -p $XDG_DATA_DIR
  LOCAL_VENV="$XDG_DATA_DIR/venv"
  python3 -m venv $LOCAL_VENV
  echo 'Install pipx into user venv'
  $LOCAL_VENV/bin/pip install pipx
  echo 'Manually ensurepath for pipx'
  # this will be replaced later with ansible configs
  echo 'export XDG_DATA_DIR="${XDG_DATA_DIR:-$HOME/.local/share}"' >> ~/.zshrc
  echo 'export LOCAL_VENV="$XDG_DATA_DIR/venv"' >> ~/.zshrc
  echo 'export PIPX_HOME="$XDG_DATA_DIR/pipx"' >> ~/.zshrc
  echo 'export PIPX_BIN_DIR="$PIPX_HOME/bin"' >> ~/.zshrc
  echo 'export PATH="$LOCAL_VENV/bin:$PATH:$PIPX_BIN_DIR"' >> ~/.zshrc
}


ensurepath_pipx() {
  echo 'ensurepath pipx'
  pipx ensurepath
}


install_ansible() {
  echo 'Install ansible with pipx'
  pipx install ansible
}
