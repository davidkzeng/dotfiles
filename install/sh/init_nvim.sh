#!/bin/bash

echo ">>> Started init_nvim.sh"
plug_file="$XDG_DATA_HOME"/nvim/site/autoload/plug.vim
if [ ! -e "$plug_file" ]; then
    # Install vimplug
    curl -fLo "$plug_file" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi
echo "<<< Completed init_nvim.sh"
