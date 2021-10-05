#!/bin/bash

# should learn nix at some point to avoid using bash scripts to set this up

echo ">>> Started init_custom.sh"

dotfiles_dir="$(dirname "$(dirname "$(realpath "$0")")")"

if [[ -z "$(ls -A $dotfiles_dir/custom/research-tools)" ]]; then
    echo "Submodule not inited, try running git submodule update --init"
    exit 1
fi

echo "<<< Completed init_custom.sh"
