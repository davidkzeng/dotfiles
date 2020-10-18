echo ">>> Started link_files.sh"

dotfiles_dir=$1
force_link=$2
home_mirror="${dotfiles_dir}/mirror"

function safe_link() {
    target=$1
    link=$2

    if [[ -e "$link" ]]; then
        if [[ -L "$link" ]] && [[ "$(readlink $link)" == "$target" ]]; then
            echo "$link already links to target... ignoring"
        else
            if [[ "$force_link" -eq 1 ]]; then
                echo "WARN: $link already exists... replacing with symlink"
                rm -r "$link"
                ln -s "$target" "$link"
            else
                echo "WARN: $link already exists... ignoring"
            fi
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

to_link=(
    vimrc
    profile
    bash_profile
    bashrc
    zshrc
    config/bash
    config/nvim
    config/tmux
    config/git
    config/Code/User/settings.json
    config/Code/User/keybindings.json
)
for file in "${to_link[@]}"; do
    safe_link "$home_mirror/$file" "$HOME/.$file"
done

mkdir -p "$HOME/bin"
safe_link "$home_mirror/bin/personal_bin" "$HOME/bin/personal_bin"

echo "<<< Completed link_files.sh"
