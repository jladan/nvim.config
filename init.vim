if &shell =~# 'fish$'
  set shell=/usr/bin/env\ bash
endif

colorscheme jladan
call togglebg#map("<F5>")
hi CursorLine cterm=undercurl guisp=DarkMagenta

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

Plug 'tpope/vim-commentary'

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


" My lua configurations for plugins
lua << EOF
require "jladan.lsp"
require "jladan.telescope"

require "nvim-treesitter.configs".setup {
    -- modules and their options
    highlight = { 
        enable = true,
        disable = {'org', 'markdown', 'elixir'},
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
    au WinEnter *.tex,*.lua setlocal foldmethod=expr
    au WinEnter *.tex,*.lua setlocal foldexpr=nvim_treesitter#foldexpr()
augroup END
