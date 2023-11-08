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
      ];
    };

    # TODO: tmux config

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
