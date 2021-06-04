# Ubuntu install for 20.04 or above

echo "Installing packages"

default_install=(neovim git htop zsh fzf nix)

sudo apt install ${default_install[@]}

nix-env --install tmux ripgrep
