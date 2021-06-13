#!/bin/bash

# Ubuntu install for 20.04 or above
set -e

echo "Installing packages"

sh_dir="$(dirname "$(realpath "$0")")"
. "${sh_dir}/utils.sh"

if ! has_cmd nix; then
    # For some reason the install modifies zshrc/bash_profile, please delete
    curl -L https://nixos.org/nix/install | sh
    . /home/${USER}/.nix-profile/etc/profile.d/nix.sh
fi

nix-env --install -A nixpkgs.myPackages
