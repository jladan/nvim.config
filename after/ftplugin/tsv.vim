setlocal noexpandtab
setlocal tabstop=4
setlocal softtabstop=0

" Virtual editing to manage spacing
" The actual virtual edit is a global setting, so it's handled in an autocommand
" in filetype.vim
nnoremap <buffer> r gr
nnoremap <buffer> R gR

" First line is a header
call matchaddpos("Title", [1])
