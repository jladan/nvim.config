if &shell =~# 'fish$'
  set shell=/usr/bin/env\ bash
endif

let mapleader = " "

" I kept accidentally doing <c-z><c-z> instead of ZZ, so this fixes it and
" adds saving
noremap <C-Z> <cmd>w<CR>

colorscheme jladan
call togglebg#map("<F4>")

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

" The rest of the stuff should not execute for root user
if system('whoami') =~ 'root'
    let g:warn_root = 1
    finish
end

call plug#begin(stdpath('data') . '/plugged')
Plug 'neovim/nvim-lspconfig'

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

" Actually super cool
Plug 'mbbill/undotree'

" Git in vim
Plug 'tpope/vim-fugitive'

" Treesitter does parses languages
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'
Plug 'nvim-treesitter/nvim-treesitter-textobjects'

" Orgmode based on treesitter, like I wanted
Plug 'kristijanhusak/orgmode.nvim', {'branch': 'tree-sitter'}
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

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.markdown = {
    install_info = {
        url = "https://github.com/ikatyang/tree-sitter-markdown",
        files = { "src/parser.c", "src/scanner.cc" },
        branch = "master"
    },
    filetype = "markdown",
    used_by = {"md", }
}
parser_config.org = {
    install_info = {
        url = 'https://github.com/milisims/tree-sitter-org',
        revision = 'main',
        files = {'src/parser.c', 'src/scanner.cc'},
    },
    filetype = 'org',
}


require "nvim-treesitter.configs".setup {
    -- modules and their options
    highlight = { 
        enable = true,
        disable = {'org', 'markdown'},
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
}

require("orgmode").setup {
    org_agenda_files = {'~/Documents/diary/org/*'},
    org_default_notes_file = '$scratch/refile.org',
}
EOF


nnoremap <leader>u :UndotreeToggle<CR>

" undo break points
inoremap , ,<c-g>u
inoremap . .<c-g>u
