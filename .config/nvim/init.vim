call plug#begin()
 Plug 'neoclide/coc.nvim', {'branch': 'release'}
 Plug 'morhetz/gruvbox'
 Plug 'preservim/nerdcommenter'
 Plug 'fatih/vim-go'
 Plug 'vim-airline/vim-airline'
 Plug 'vim-airline/vim-airline-themes'
 Plug 'mhinz/vim-startify'
 Plug 'scrooloose/nerdtree'
 Plug 'xuyuanp/nerdtree-git-plugin'
 Plug 'ryanoasis/vim-devicons'
 Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
 Plug 'christoomey/vim-tmux-navigator'
 Plug 'mattn/emmet-vim'
call plug#end()

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

" Emmet config
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall

" Bind tab to autocomplete
inoremap <silent><expr> <tab> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<TAB>"
inoremap <silent><expr> <cr> "\<c-g>u\<CR>"
