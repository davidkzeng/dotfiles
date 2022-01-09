#!/bin/bash

echo ">>> Started init_tmux.sh"

if [[ ! -d "$XDG_DATA_HOME/tmux/tpm" ]]; then
    git clone https://github.com/tmux-plugins/tpm "$XDG_DATA_HOME/tmux/tpm"
fi

echo "<<< Completed init_tmux.sh"
