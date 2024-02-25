while getopts 'hk' OPTION; do
    case "$OPTION" in
        h)
            echo "Usage: $0 [OPTIONS]"
            echo "Options:"
            echo " -h,      Display this help message"
            echo " -k,      Install the kitty terminal"
            ;;
        k)
            # install kitty
            echo "Installing kitty terminal"
            curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
            ;;
        ?)
            echo "script usage: $(basename \$0) [-hk] >&2"
            ;;
    esac
done
shift "$(($OPTIND -1))"

# install nix
sh <(curl -L https://nixos.org/nix/install) --daemon

# source nix(?)

# install home-manager
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update

nix-shell '<home-manager>' -A install

# verify we installed home-manager
if ! command -v home-manager &> /dev/null
then
    echo "home-manager was not installed"
    exit 1
fi

# TODO: install golang?
# curl https://go.dev/dl/go1.21.4.linux-amd64.tar.gz
# rm -rf /usr/local/go && tar -C /usr/local -xzf go1.21.4.linux-amd64.tar.gz

# install stow
cd /tmp
curl -o stow-latetst.tar.gz https://ftp.gnu.org/gnu/stow/stow-latest.tar.gz
tar -xzpf stow-latest.tar.gz && rm stow-latest.tar.gz
cd stow-*
./configure && make
make install
cd
if ! command -v stow &> /dev/null
then
    echo "stow could not be found"
    exit 1
fi

# stow dotfiles 
cd .dotfiles
mkdir -p "$HOME/.config/home-manager" "$HOME/.config/kitty"  # shouldn't be necessary but just in case
stow home-manager -t "$HOME/.config/home-manager"
stow kitty -t "$HOME/.config/kitty"
home-manager switch

# add zsh to valid login shells
command -v zsh | sudo tee -a /etc/shells

# switch default shell to zsh
sudo chsh -s $(which zsh) $USER
