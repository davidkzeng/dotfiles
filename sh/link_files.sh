echo "Started link_files.sh"

dotfiles_dir=$(dirname $(dirname $(realpath "$0")))

to_link=(tmux.conf nvimrc bashrc.common gitconfig)
for file in "${to_link[@]}"; do
    ln -sf "$dotfiles_dir/$file" "$HOME/.$file"
done

rm -rf "$HOME/bin"
mkdir "$HOME/bin"
ln -sf "$dotfiles_dir/bin" "$HOME/bin/custom-bin"

echo "Completed link_files.sh"