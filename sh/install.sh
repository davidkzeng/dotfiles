#!/bin/bash

# Ubuntu install for 20.04 or above
set -e

echo "Installing packages"

sh_dir="$(dirname "$(realpath "$0")")"
. "${sh_dir}/utils.sh"

if ! has_cmd pip3; then
    sudo apt install pip3
fi

if ! has_cmd nix; then
    curl -L https://nixos.org/nix/install | sh
    . /home/${USER}/.nix-profile/etc/profile.d/nix.sh
fi

nix-env --install -A nixpkgs.myPackages
