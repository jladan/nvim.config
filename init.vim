if &shell =~# 'fish$'
  set shell=/usr/bin/env\ bash
endif

let mapleader = " "

set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent

set viewoptions-=options

" Loads the vimrc in current directory (for special project configs)
set exrc

set relativenumber
set nu
set cursorline

" Sanity
set nowrap
set hidden
set noerrorbells

" nice stuff
set scrolloff=4
set laststatus=2
set splitright      "new windows to right instead of left
set splitbelow


" primeagen suggestions
set noswapfile
set nobackup
let &undodir = stdpath('data') . '/undodir'
set undofile

" Searching options
set incsearch
set ignorecase
set smartcase
set nohlsearch

call plug#begin(stdpath('data') . '/plugged')
Plug 'neovim/nvim-lspconfig'

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

" Actually super cool
Plug 'mbbill/undotree'

Plug 'tpope/vim-fugitive'
call plug#end()

" appearance stuff
set guicursor=
highlight Normal guibg=none
set colorcolumn=80
hi ColorColumn guibg=#2e2e2e ctermbg=237
set signcolumn=yes

" Fancy status line {{{
" TODO fix the colors
function! MyStatusLine(mode)
    let statusline=""
    if a:mode == 'Enter'
        let statusline.="%1*"
    else
        let statusline.="%0*"
    endif
    let statusline.="\(%n\)\ %f\ "
    let statusline.="%2*%m"
    let statusline.="%r%*"
    let statusline .= "\ (%l/%L,\ %c)\ %P%=%h%w\ %y\ [%{&encoding}:%{&fileformat}]\ \ "
    return statusline
endfunction

au WinEnter * setlocal statusline=%!MyStatusLine('Enter')
au WinLeave * setlocal statusline=%!MyStatusLine('Leave')
set statusline=%!MyStatusLine('Enter')

function! InsertStatuslineColor(mode)
  if a:mode == 'i'
    hi StatColor guibg=orange ctermbg=lightred
  elseif a:mode == 'r'
    hi StatColor guibg=#e454ba ctermbg=magenta
  elseif a:mode == 'v'
    hi StatColor guibg=#e454ba ctermbg=magenta
  else
    hi StatColor guibg=red ctermbg=red
  endif
endfunction 
"}}}



" wildmenu
set wildmode=longest,list,full
set wildmenu
set path+=**
" ignore files
set wildignore+=*.pyc
set wildignore+=**/.git/*

let g:tex_flavor = "latex"

" netrw (file browsing) configs {{{
let g:netrw_banner=0        " no banner at top
let g:netrw_browse_split=4  " open in previous window (behave like 'P')
let g:netrw_liststyle=3     " tree view
let g:netrw_winsize=70
let g:netrw_altv=1          " split to right (when 'v' is pressed)
" }}}


" Trying out lsp with python
lua << EOF
require "jladan.lsp"
require "jladan.telescope"
EOF


nnoremap <leader>u :UndotreeToggle<CR>

" undo break points
inoremap , ,<c-g>u
inoremap . .<c-g>u
