if &shell =~# 'fish$'
  set shell=/usr/bin/env\ bash
endif

let mapleader = " "

colorscheme jladan
call togglebg#map("<F5>")

" Default tab options for most files
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent

set viewoptions-=options

" Loads the vimrc in current directory (for special project configs)
set exrc

" Line number settings
set relativenumber
set nu
set cursorline

" Default to use markers in folding
set foldmethod=marker

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

" appearance stuff
set guicursor=
highlight Normal guibg=none
set colorcolumn=80
hi ColorColumn guibg=#2e2e2e ctermbg=237
set signcolumn=yes

let g:warn_root = 0
" Fancy status line {{{
" TODO fix the colors
function! MyStatusLine(mode)
    if win_gettype() == 'preview'
        return ""
    end
    let statusline=""
    if a:mode == 'Enter'
        let statusline.="%1*"
    else
        let statusline.="%0*"
    endif
    if g:warn_root
        let statusline.="ROOT"
    end
    let statusline.="\(%n\)\ %f\ "
    let statusline.="%2*%m"
    let statusline.="%r%*"
    let statusline .= "\ (%l/%L,\ %c)\ %P%=%h%w\ %y\ [%{&encoding}:%{&fileformat}]\ \ "
    return statusline
endfunction

augroup statusline
    au WinEnter * setlocal statusline=%{%MyStatusLine('Enter')%}
    au WinLeave * setlocal statusline=%{%MyStatusLine('Leave')%}
augroup END

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

" The rest of the stuff should not execute for root user
if system('whoami') =~ 'root'
    let g:warn_root = 1
    finish
end

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'neovim/nvim-lspconfig'

" Languages
Plug 'elixir-editors/vim-elixir'

" Telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }

" Snippets
Plug 'L3MON4D3/LuaSnip'
Plug 'rafamadriz/friendly-snippets'

" Actually super cool
Plug 'mbbill/undotree'

" Git in vim
Plug 'tpope/vim-fugitive'

" Treesitter does parses languages
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'
Plug 'nvim-treesitter/nvim-treesitter-textobjects'

" Things to make developing with lua easier
Plug 'bfredl/nvim-luadev'

" My own latex plugin
let g:plug_url_format = 'git@github.com:%s.git'
Plug 'jladan/nvim-latex'
unlet g:plug_url_format
call plug#end()


let g:tex_flavor = "latex"

" netrw (file browsing) configs {{{
let g:netrw_banner=0        " no banner at top
let g:netrw_browse_split=4  " open in previous window (behave like 'P')
let g:netrw_liststyle=3     " tree view
let g:netrw_winsize=70
let g:netrw_altv=1          " split to right (when 'v' is pressed)
" }}}

" My lua configurations for plugins
lua << EOF
require "jladan.lsp"
require "jladan.telescope"

require "nvim-treesitter.configs".setup {
    -- modules and their options
    highlight = { 
        enable = true,
        disable = {'latex', 'tex', 'org', 'markdown', 'elixir'},
        additional_vim_regex_highlighting = {'org'},
    },
    textobjects = { enable = true },
    ensure_installed = {'org', 'markdown'},
    playground = {
        enable = true,
        disable = {},
        updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = false, -- Whether the query persists across vim sessions
        keybindings = {
            toggle_query_editor = 'o',
            toggle_hl_groups = 'i',
            toggle_injected_languages = 't',
            toggle_anonymous_nodes = 'a',
            toggle_language_display = 'I',
            focus_language = 'f',
            unfocus_language = 'F',
            update = 'R',
            goto_node = '<cr>',
            show_help = '?',
        },
    },
    query_linter = {
        enable = true,
        use_virtual_text = true,
        lint_events = {"BufWrite", "CursorHold"},
    },
    ensure_installed = "maintained",
}

EOF

" Treesitter folding
augroup treefold
    au WinEnter *.py,*.tex,*.lua setlocal foldmethod=expr
    au WinEnter *.py,*.tex,*.lua setlocal foldexpr=nvim_treesitter#foldexpr()
augroup END

nnoremap <leader>u :UndotreeToggle<CR>

" undo break points
inoremap , ,<c-g>u
inoremap . .<c-g>u
