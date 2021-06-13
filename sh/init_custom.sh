#!/bin/bash

# should learn nix at some point to avoid using bash scripts to set this up

echo ">>> Started init_custom.sh"

dotfiles_dir="$(dirname "$(dirname "$(realpath "$0")")")"

echo "<<< Completed init_custom.sh"
