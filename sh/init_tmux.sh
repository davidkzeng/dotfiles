#!/bin/bash

echo ">>> Started init_tmux.sh"

if [[ ! -d ~/.tmux/plugins/tpm ]]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    ~/.tmux/plugins/tpm/bin/install_plugins
fi

echo "<<< Completed init_tmux.sh"
