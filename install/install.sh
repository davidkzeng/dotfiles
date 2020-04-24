# Assumes python3 availability

echo ">>> Started install.sh"

install_dir=$(dirname $(realpath "$0"))

sudo python3 "$install_dir/install.py"

echo "<<< Completed install.sh"
