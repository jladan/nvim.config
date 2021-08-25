function! s:swap_lines(n1, n2)
    let line1 = getline(a:n1)
    let line2 = getline(a:n2)
    call setline(a:n1, line2)
    call setline(a:n2, line1)
endfunction

function! s:swap_up()
    let n = line('.')
    if n == 1
        return
    endif

    call s:swap_lines(n, n - 1)
    exec n - 1
endfunction

function! s:swap_down()
    let n = line('.')
    if n == line('$')
        return
    endif

    call s:swap_lines(n, n + 1)
    exec n + 1
endfunction

if has("unix")
    let s:uname = system("uname -s")
    if s:uname =~ "darwin"
        " Then I am a Mac
        " And the alt key doesn't work properly
        noremap <silent> ˚ :call <SID>swap_up()<CR>
        noremap <silent> ∆ :call <SID>swap_down()<CR>
    else
        " I'm probably linux
        noremap <silent> <M-k> :call <SID>swap_up()<CR>
        noremap <silent> <M-j> :call <SID>swap_down()<CR>
    endif
else
    " Let's just assume I'm on windows if not unix
    noremap <silent> <M-k> :call <SID>swap_up()<CR>
    noremap <silent> <M-j> :call <SID>swap_down()<CR>
endif
