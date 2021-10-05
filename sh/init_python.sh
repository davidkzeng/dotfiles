#!/bin/bash

# Assume python3 with pip is available available
# Install python based tools that are either
# 1. unavailable in nix or
# 2. would rather install through the python ecosystem

set -e

echo ">>> Started init_python.sh"
sh_dir="$(dirname "$(realpath "$0")")"
. "${sh_dir}/utils.sh"

if ! has_cmd python3; then
    sudo apt install python3
    sudo apt install python3.8-venv
fi

if ! has_cmd python; then
    sudo apt install python-is-python3
fi

if ! has_cmd pip3; then
    sudo apt install python3-pip
fi

if ! has_cmd virtualenv; then
    sudo apt install python3-venv
fi

if ! has_cmd pipx; then
    python3 -m pip install --user pipx
fi

if ! has_cmd poetry; then
    pipx install poetry
fi

if ! has_cmd pyls; then
    pipx install python-language-server
fi

if ! has_cmd smdv; then
    pipx install git+https://github.com/davidkzeng/smdv.git
fi

echo "<<< Completed init_python.sh"
