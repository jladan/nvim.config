setlocal noexpandtab
setlocal tabstop=4
setlocal softtabstop=0

" Virtual editing to manage spacing
setlocal virtualedit=all
nnoremap <buffer> r gr
nnoremap <buffer> R gR

" First line is a header
call matchaddpos("Title", [1])
