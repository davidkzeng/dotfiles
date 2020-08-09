echo ">>> Started link_files.sh"

dotfiles_dir=$1
home_mirror="${dotfiles_dir}/mirror"

function safe_link() {
    target=$1
    link=$2

    if [[ -e "$link" ]]; then
        if [[ -L "$link" ]] && [[ "$(readlink $link)" == "$target" ]]; then
            echo "$link already links to target... ignoring"
        else
            echo "$link already exists... ignoring"
        fi
    elif [[ ! -e "$target" ]]; then
        echo "$target does not exist... ignoring"
    else
        if [[ -L "$link" ]]; then
            echo "Removing broken symlink $link"
            rm $link
        fi
        echo "Added symlink $link -> $target"
        ln -s "$target" "$link"
    fi
}

safe_link "$dotfiles_dir" "$HOME/.dotfiles"

to_link=(tmux.conf nvimrc gitconfig gitignore_global bash_aliases bash_functions bashrc_base)
for file in "${to_link[@]}"; do
    safe_link "$home_mirror/$file" "$HOME/.$file"
done

to_link_config=(
    config/nvim/init.vim
    config/nvim/coc-settings.json
    config/Code/User/settings.json
    config/Code/User/keybindings.json
)
for file in "${to_link_config[@]}"; do
    safe_link "$home_mirror/$file" "$HOME/.$file"
done

mkdir -p "$HOME/bin"
safe_link "$home_mirror/bin/custom_bin" "$HOME/bin/custom_bin"

echo "<<< Completed link_files.sh"
