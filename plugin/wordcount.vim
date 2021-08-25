function! VisualCountWords() range
    let n = @n
    silent! normal gv"ny
    echo "Word count:" . system("wc -w", @n)
    let @n = n
    " bonus: restores the visual selection
    normal! gv 
endfunction

vnoremap <C-g> :call VisualCountWords()<cr>
