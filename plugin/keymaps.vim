" Quit without saving (but not if there are changes)
nnoremap <silent> ZH :q<CR>
" navigation through quickfix (actually loclist)
nnoremap <silent> ]e :lbelow<CR>
nnoremap <silent> ]E :labove<CR>

" Underlining commands for comments and markdown
nnoremap <leader>u yypVr
inoremap <expr> <C-h>u "\<esc>yypVr" . nr2char(getchar()) . "o"

" To help with code refactoring, search through all files for current word
nnoremap <silent> <leader>r :vimgrep <cword> **/*.py<cr>:cope<cr><C-W>p
" Navigate the quickfix list
nnoremap <silent> ]U :cp<cr>
nnoremap <silent> ]u :cn<cr>

" buffer navigation
nnoremap <silent> ]e :bn<cr>
nnoremap <silent> ]. :bp<cr>
noremap ]<space> :b<space>

"" The following from ThePrimeagen
" Improved copying
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y gg"+yG

" Moving text
" The `=` takes care of indenting
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
nnoremap <leader>j :m .+1<CR>==
nnoremap <leader>k :m .-2<CR>==
