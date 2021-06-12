#!/bin/bash

# Assume python3 with pip is available available
# Install python based tools that are either
# 1. unavailable in nix or
# 2. would rather install through the python ecosystem

set -e

echo ">>> Started init_python.sh"
sh_dir="$(dirname "$(realpath "$0")")"
. "${sh_dir}/utils.sh"

if ! has_cmd pipx; then
    python3 -m pip install --user pipx
fi

if ! has_cmd poetry; then
    pipx install poetry
fi

if ! has_cmd pyls; then
    pipx install pyls
fi

# if ! has_cmd smdv; then
#     pipx install smdv
# fi
# currently using some hacks to manual build own version of smdv

echo "<<< Completed init_python.sh"
