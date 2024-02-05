" All of vim options

" Don't like moving cursor with mouse, 
" but wish it would work with other UI features
set mouse=""

" Default tab options for most files
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent

set viewoptions-=options

" Loads the vimrc in current directory (for special project configs)
" This is one of (in order of precedence)
" - ".nvim.lua"
" - ".nvimrc"
" - ".exrc"
set exrc

" Line number settings
set relativenumber
set nu
set cursorline
hi CursorLine ctermbg=none cterm=undercurl guibg=none gui=undercurl guisp=DarkMagenta

" Default to use markers in folding
set foldmethod=marker

" Sanity
set nowrap
set hidden
set noerrorbells
set foldlevel=99

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

" appearance stuff
set guicursor=n-v:block,ci-i:ver25
highlight Normal guibg=none
set colorcolumn=80
hi ColorColumn guibg=#2e2e2e ctermbg=237
set signcolumn=yes

" wildmenu
" set wildmode=longest,list,full
" set wildmenu

" Include all directories in current path
" Don't think this is necessary
" set path+=**

" ignore files
set wildignore+=*.pyc
set wildignore+=**/.git/*

let g:tex_flavor = "latex"

" TODO: actually decide how I want netrw to behave
" netrw (file browsing) configs {{{
let g:netrw_banner=0        " no banner at top
let g:netrw_browse_split=4  " open in previous window (behave like 'P')
let g:netrw_liststyle=3     " tree view
let g:netrw_winsize=70
let g:netrw_altv=1          " split to right (when 'v' is pressed)
" }}}

