# Ubuntu install for 20.04 or above

echo "Installing packages"

default_install=(neovim tmux git htop zsh fzf)

sudo apt install ${default_install[@]}
