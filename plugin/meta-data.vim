" Collection of metadata related functions (author, date, etc.)
"
" General usage:
" In insert mode, the piece of data is inserted at the current location
" In normal mode, we load the data into a register so it can be immediately
" placed with p or P. Thus:
"   insert before current character: <leader>dP
"   insert after  current character: <leader>dp
"
" This is to allow for flexible placement (beginning or end of a line)

" Current Date Mappings (d)
nnoremap <leader>d "=strftime('%F')<CR>
inoremap <C-space>d <C-R>=strftime('%F')<CR>

" Current Time Mappings (t)
nnoremap <leader>t "=strftime('%H:%M')<CR>
inoremap <C-space>t <C-R>=strftime('%H:%M')<CR>

" Author (a)
nnoremap <leader>a "='John Ladan'<CR>
inoremap <C-space>a John Ladan
