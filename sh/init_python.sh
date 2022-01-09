#!/bin/bash

# python via nix is too difficult
# 1. need to install system dependencies expected by packages (e.x zlib)
# 2. pip incompatibility

sh_dir="$(dirname "$(realpath "$0")")"
. "${sh_dir}/utils.sh"

# ubuntu quirk
if ! dpkg -l python-is-python3 > /dev/null; then
    sudo apt install python-is-python3
fi

if ! dpkg -l python3-pip > /dev/null; then
    sudo apt install python3-pip
fi

if ! pip list | grep pipx > /dev/null; then
    python3 -m pip install --user pipx
fi

if ! pipx list | grep poetry > /dev/null; then
    pipx install poetry
fi

if ! pipx list | grep python-language-server > /dev/null; then
    pipx install python-language-server
fi

if ! pipx list | grep smdv > /dev/null; then
    pipx install git+https://github.com/davidkzeng/smdv.git
fi
