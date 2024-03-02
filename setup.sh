# install home-manager
echo "~~~INSTALLING home-manager~~~"
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update

nix-shell '<home-manager>' -A install

# verify we installed home-manager
if ! [ -x "$(command -v home-manager)" ];
then
    echo "home-manager was not installed"
    exit 1
fi

# stow dotfiles
echo "~~~STOWING dotfiles~~~"
cd $HOME/.dotfiles
mkdir -p "$HOME/.config/home-manager" "$HOME/.config/kitty"  # shouldn't be necessary but just in case
stow --adopt . && git restore .
sed -i '5 a \ \ home.username = "'"$(whoami)"'";\n\ \ home.homeDirectory = "'"$HOME"'";' .config/home-manager/home.nix

home-manager switch

# add zsh to valid login shells
if ! [ -x "$(command -v zsh)" ];
then
    echo "zsh was not installed"
    exit 1
fi
echo "$(command -v zsh)" | sudo tee -a /etc/shells

# switch default shell to zsh
echo "~~~CHANGING DEFAULT SHELL~~~"
chsh -s "$(command -v zsh)" "$(whoami)"
