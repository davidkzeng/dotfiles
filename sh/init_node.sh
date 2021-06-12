#!/bin/bash

# Install node based tools that are either
# 1. unavailable in nix or
# 2. would rather install through the node ecosystem

set -e

echo ">>> Started init_node.sh"
sh_dir="$(dirname "$(realpath "$0")")"
. "${sh_dir}/utils.sh"

if ! has_cmd instant-markdown-d; then
    npm install -g instant-markdown-d
fi

echo "<<< Completed init_node.sh"
