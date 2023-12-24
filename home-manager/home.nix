{ config, pkgs, ... }:

# see https://mipmip.github.io/home-manager-option-search/ for a (3rd party) list of options
{
  home.username = "joon";
  home.homeDirectory = "/home/joon";

  home.stateVersion = "23.05"; # Please read the comment before changing.

  targets.genericLinux.enable = true;

  # see search.nixos.org/packages
  home.packages = with pkgs; [
    direnv	# directory-specific (if .envrc is present) environment variables
    htop	# process viewer
    fzf		# fuzzy finder
    neofetch	# system info
    ripgrep	# fast text search
    tmux	# terminal multiplexer
  ];

  programs = {
    bat = {
      enable = true;
      config = {
        italic-text = "always";
      };
    };

    git = {
      enable = true;
      userName = "Joon Lee";
      userEmail = "joon.lee727@gmail.com";
      extraConfig = {
        core = {
          editor = "nvim";
        };
        color = {
          ui = true;
        };
      };
    };

    neovim = {
      enable = true;
      defaultEditor = true;
      vimAlias = true;
      extraConfig = ''
        set nocompatible            " disable compatibility to old-time vi
        set showmatch               " show matching 
        set ignorecase              " case insensitive 
        set smartcase
        set mouse=v                 " middle-click paste with 
        set hlsearch                " highlight search 
        set incsearch               " incremental search
        set tabstop=4               " number of columns occupied by a tab 
        set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
        set expandtab               " converts tabs to white space
        set shiftwidth=4            " width for autoindents
        set autoindent              " indent a new line the same amount as the line just typed
        set number                  " add line numbers
        set relativenumber
        set wildmode=longest,list   " get bash-like tab completions
        set cc=80                   " set an 80 column border for good coding style
        filetype plugin indent on   " allow auto-indenting depending on file type
        filetype plugin on
        syntax on                   " syntax highlighting
        set mouse=a                 " enable mouse click
        set clipboard=unnamedplus   " using system clipboard
        " set cursorline              " highlight current cursorline
        set ttyfast                 " Speed up scrolling in Vim
        set termguicolors           " Better colors(?)
        colorscheme gruvbox

        " Nerdcommenter config
        let g:NERDCreateDefaultMappings = 1   
        let g:NERDSpaceDelims = 1
        let g:NERDCompactSexyComs = 1
        let g:NERDCommentEmptyLines = 1
        let g:NERDTrimTrailingWhitespace = 1
        let g:NERDToggleCheckAllLines = 1

        " Nerdtree config
        let NERDTreeShowHidden = 1
        nnoremap <leader>n :NERDTreeFocus<CR>
        nnoremap <C-n> :NERDTree<CR>
        nnoremap <C-t> :NERDTreeToggle<CR>
        nnoremap <C-f> :NERDTreeFind<CR>
      '';
      coc.enable = true;
      plugins = with pkgs.vimPlugins; [
        gruvbox
        nerdcommenter
        vim-nix
        vim-go
        vim-airline
        vim-airline-themes
        vim-startify
        nerdtree
        nerdtree-git-plugin
        vim-devicons
        vim-nerdtree-syntax-highlight
        vim-tmux-navigator
      ];
    };

    tmux = {
      enable = true;
      shell = "$SHELL";
      terminal = "tmux-256color"; 
      baseIndex = 1;
      mouse = true;
      prefix = "C-space";
      plugins = with pkgs.tmuxPlugins; [
        sensible
        vim-tmux-navigator
        catppuccin
        # tmux-yank
      ];
      extraConfig = ''
        # Force 24-bit color if possible
        set-option -sa terminal-overrides ",xterm*:Tc"

        # Set prefix to something other than default (Ctrl-b -> Ctrl-space)
        # unbind C-b
        # set -g prefix C-space
        # bind C-space send-prefix

        # Shift + Alt + vim keys to switch windows
        bind -n M-H previous-window
        bind -n M-L next-window

        # Mouse support
        # set -g mouse on

        # Start indexing at 1
        # set -g base-index 1
        # set -g pane-base-index 1
        # set-window-option -g pane-base-index 1
        # set-option -g renumber windows on

        # Set vi-mode
        set-window-option -g mode-keys vi

        # Keybindings for copying
        bind-key -T copy-mode-vi v send-keys -X begin-selection
        bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
        # bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

        # Open panes in current directory
        bind '"' split-window -v -c "#{pane_current_path}"
        bind % split-window -h -c "#{pane_current_path}"

        set -g @catpuccin_flavour 'mocha'
      '';
    };

    zsh = {
      enable = true;
      enableAutosuggestions = true;
      syntaxHighlighting.enable = true;
      shellAliases = {
        mkdir = "mkdir -p";
        nix-clean = "nix-collect-garbage";
      };
      initExtra = ''
        [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
        export PATH=$PATH:/usr/local/go/bin
        export NVM_DIR="$HOME/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
        [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
      '';
      plugins = [
        {
          name = "powerlevel10k";
          src = pkgs.zsh-powerlevel10k;
          file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
        }
      ];
      oh-my-zsh = {
        enable = true;
        plugins = [
          "colored-man-pages"
          "command-not-found"
        ];
      };
    };

  };

  home.file = {
  };

  home.sessionVariables = {
  };

  programs.home-manager.enable = true;
}
