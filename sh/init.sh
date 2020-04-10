# Sets up environment

# Assumes the following dependencies
# git, tmux

sh_dir=$(dirname $(realpath "$0"))

# Create symlinks for dotfiles
./"$sh_dir"/link_files.sh
echo "source ~/.bashrc.common" >> $HOME/.bashrc

./"$sh_dir"/init_tmux.sh
