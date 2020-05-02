echo ">>> Started link_files.sh"

function safe_link() {
    target=$1
    link=$2

    if [[ -e "$link" ]]; then
        echo "$link already exists... ignoring"
    elif [[ ! -e "$target" ]]; then
        echo "$target does not exist... ignoring"
    else
        echo "Added symlink $link -> $target"
        ln -s "$target" "$link"
    fi
}

dotfiles_dir=$(dirname $(dirname $(realpath "$0")))

safe_link "$dotfiles_dir" "$HOME/.dotfiles"

to_link=(tmux.conf nvimrc gitconfig gitignore_global bash_aliases bash_functions bashrc_base)
for file in "${to_link[@]}"; do
    safe_link "$dotfiles_dir/$file" "$HOME/.$file"
done

safe_link "$dotfiles_dir/apps/vim/coc/coc-settings.json" "$HOME/.config/nvim/coc-settings.json"
safe_link "$dotfiles_dir/apps/vscode/settings.json" "$HOME/.config/Code/User/settings.json"

mkdir -p "$HOME/bin"
safe_link "$dotfiles_dir/bin" "$HOME/bin/custom_bin"

echo "<<< Completed link_files.sh"
