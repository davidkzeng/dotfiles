# Available in default repos for 20.04 and above

echo "Installing packages"

default_install=(neovim tmux git htop zsh fzf)

sudo apt install ${default_install[@]}
