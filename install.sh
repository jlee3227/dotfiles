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
curl -L https://nixos.org/nix/install | sh -s -- --daemon --yes

if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi

# Testing whether Nix is available in subsequent commands
nix --version

# source nix(?)

# install stow
echo "\n~~~INSTALLING stow~~~"
cd /tmp
curl -o stow-latest.tar.gz https://ftp.gnu.org/gnu/stow/stow-latest.tar.gz
tar -xzpf stow-latest.tar.gz && rm stow-latest.tar.gz
cd stow-*
./configure && make
make install
cd
if ! [ -x "$(command -v stow)" ];
then
    echo "stow could not be found"
    exit 1
fi

echo "Finished installing, please move on to setup"
