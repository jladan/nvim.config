set textwidth=80

" Set up neovim socket in cwd
if index(serverlist(), '.nvim.sock') == -1
    call serverstart('.nvim.sock')
    echo 'started nvim server'
end

" forward synctex to zathura
" TODO: find the desired pdf 
"  - go up from file until we find a pdf
"  - if there are multiple pdfs, check which one to use
function! Synctex()
    if exists("g:syncpdf")
        execute "silent !zathura --synctex-forward " . line('.') . ":" . col('.') . ":" . bufname('%') . " " . g:syncpdf
    else
        echo "g:syncpdf is not set"
    endif
    redraw!
endfunction

nnoremap ]p <cmd>call Synctex()<cr>
