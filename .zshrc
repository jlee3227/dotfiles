# Created by ejun for 5.8.1

# Enable if on macos:
# eval "$(/opt/homebrew/bin/brew shellenv)"
# if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
# 	eval "(oh-my-posh init zsh)"
# fi

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
	mkdir -p "$(dirname $ZINIT_HOME)"
	git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# For customizing CLI prompt
eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/zen.toml)"
# eval "$(oh-my-posh init zsh --config https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/pararussel.omp.json)"

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found

# Load completions
autoload -U compinit && compinit

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups 
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

# Aliases
alias ls='ls --color'
alias vim='nvim'
alias mkdir='mkdir -p'

# Shell Integrations
# eval "$(fzf --zsh)" # use with ^r 
# eval "$(zoxide init --cmd cd zsh)"

eval "$(/opt/homebrew/bin/brew shellenv)"
if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
	export PATH="$PATH:$HOME/go/bin"
else
    export PATH="$PATH:/usr/local/go/bin"
fi

# fnm
FNM_PATH="/home/$(whoami)/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="/home/$(whoami)/.local/share/fnm:$PATH"
  eval "`fnm env`"
fi

# fnm
FNM_PATH="/Users/jlee/Library/Application Support/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="/Users/jlee/Library/Application Support/fnm:$PATH"
  eval "$(fnm env --use-on-cd --shell zsh)"
fi

eval "$(fnm env --use-on-cd --shell zsh)"
