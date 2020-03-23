dotfiles_dir=$(dirname $(realpath "$0"))

to_link=(tmux.conf nvimrc bashrc.common)
for file in "${to_link[@]}"; do
    ln -sf "$dotfiles_dir/$file" "$HOME/.$file"
done

