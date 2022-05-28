" I kept accidentally doing <c-z><c-z> instead of ZZ, so this fixes it and
" adds saving
noremap <silent> <C-Z> <cmd>w<CR>
" Quit without saving (but not if there are changes)
nnoremap <silent> ZH :q<CR>

" My down-arrow is below j, so sometimes I hit <S-Down> instead of J
nnoremap <S-Down> J

" Shortcuts into the <C-X> completion menu
inoremap <C-F> <C-X><C-F>
inoremap <C-L> <C-X><C-L>

" navigation through quickfix (actually loclist)
nnoremap <silent> ]e :lbelow<CR>
nnoremap <silent> ]E :labove<CR>

" In insert mode, I use <C-space> as a leader, but <C-space><C-space> defaults
" to repeating thet  last insert mode command.
" My keyboard has also started double-tapping space, which is really annoying.
" This fixes that issue
imap <C-space><C-space> <C-space>
nmap <space><space> <space>

" Underlining commands for comments and markdown
nnoremap <leader>u :t .<CR>Vr
inoremap <expr> <C-space>u "<C-\><c-N>:t .<CR>Vr" . nr2char(getchar()) . "o"
inoremap <C-space>- <C-\><c-N>:t .<CR>Vr-o
inoremap <C-space>= <C-\><c-N>:t .<CR>Vr=o

" To help with code refactoring, search through all files for current word
nnoremap <silent> <leader>r :vimgrep <cword> **/*.py<cr>:cope<cr><C-W>p
" Navigate the quickfix list
nnoremap <silent> ]U :cp<cr>
nnoremap <silent> ]u :cn<cr>

" buffer navigation
nnoremap <silent> ]e :bn<cr>
nnoremap <silent> ]. :bp<cr>
noremap ]<space> :b<space>
noremap ]<C-space> :sb<space>

"" The following from ThePrimeagen
" Improved copying
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y gg"+yG
nnoremap <leader>p "+p
vnoremap <leader>p "+p

" Moving text
" The `=` takes care of indenting
vnoremap J :m '>+1<CR>gv
vnoremap K :m '<-2<CR>gv
nnoremap <leader>j :m .+1<CR>
nnoremap <leader>k :m .-2<CR>

" Snippets
" note: the expression allows overloading tab, which I normally don't like
imap <silent><expr> <tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<tab>'
inoremap <silent> <C-h> <cmd>lua require'luasnip'.jump(1)<cr>
inoremap <silent> <CS-h> <cmd>lua require'luasnip'.jump(-1)<cr>

snoremap <silent> <C-h> <cmd>lua require'luasnip'.jump(1)<cr>
snoremap <silent> <CS-h> <cmd>lua require'luasnip'.jump(-1)<cr>

imap <silent><expr> <C-e> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-e>'
smap <silent><expr> <C-e> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-e>'
