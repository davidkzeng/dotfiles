#!/bin/bash

# Ubuntu install for 20.04 or above
set -e

echo "Installing packages"

function has_cmd() {
    [[ -x "$(command -v "$1")" ]]
}

if ! has_cmd nix; then
    curl -L https://nixos.org/nix/install | sh
    . /home/${USER}/.nix-profile/etc/profile.d/nix.sh
fi

nix-env --install -A nixpkgs.myPackages
