#!/bin/bash
#
# Set up system

set -euf -o pipefail

install=0
while (( "$#" )); do
    case $1 in
        -i | --install)
        install=1
        shift ;;
    esac
done

if [[ $install -eq 1 ]]; then
    install_dir=$(dirname $(dirname $(realpath "$0")))/install
    "$install_dir"/install.sh
fi

sh_dir=$(dirname $(realpath "$0"))

# Create symlinks for dotfiles
"$sh_dir"/link_files.sh

# Add bashrc_base
if [[ -z $(grep -Fx "source ~/.bashrc_base" $HOME/.bashrc) ]]; then
    echo "source ~/.bashrc_base" >> $HOME/.bashrc
fi

"$sh_dir"/init_tmux.sh
