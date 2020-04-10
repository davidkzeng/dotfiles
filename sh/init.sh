# Sets up environment

# Assumes the following dependencies
# git, tmux

sh_dir=$(dirname $(realpath "$0"))

# Create symlinks for dotfiles
"$sh_dir"/link_files.sh
if [[ -z $(grep -Fx "source ~/.bashrc.common" $HOME/.bashrc) ]]; then
    echo "source ~/.bashrc.common" >> $HOME/.bashrc
fi

"$sh_dir"/init_tmux.sh
