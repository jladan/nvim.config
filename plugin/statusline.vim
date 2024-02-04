"Fancy status line carried over from years ago
"
" Color definitions:
hi StatuslineNC guifg=#888888
" Active window accent (green)
hi User1 ctermfg=0 ctermbg=2 guifg=#000000 guibg=#27ae60
" Modified flag accent (red)
hi User2 ctermfg=0 ctermbg=1 guifg=#000000 guibg=#c0392b

" Mode indicator
hi ModeMsg guifg=black guibg=orange ctermfg=black ctermbg=lightred 


let g:warn_root = 0
" Fancy status line {{{
function! MyStatusLine(mode)
    if win_gettype() == 'preview'
        return ""
    endif
    let statusline=""
    if a:mode == 'Enter'
        let statusline.="%1*"
    else
        let statusline.="%0*"
    endif
    if g:warn_root
        let statusline.="ROOT"
    endif
    " buffer and filename
    let statusline.="\(%n\)\ %<%f\ "
    " modified and read-only 
    let statusline.="%2*%m"
    let statusline.="%r%*"
    " Ruler
    let statusline .= "%=(%l/%L,\ %c)\ %P%=%w\ %y\ [%{&encoding}:%{&fileformat}]\ \ "
    return statusline
endfunction

augroup statusline
    " Remove all previous statusline commands
    autocmd!
    au WinEnter * setlocal statusline=%{%MyStatusLine('Enter')%}
    au WinLeave * setlocal statusline=%{%MyStatusLine('Leave')%}
    " au ModeChanged n*:* call ModeIndicator()
augroup END

set statusline=%!MyStatusLine('Enter')

" TODO: this doesn't set the indicator color before the change to insert mode
function! ModeIndicator()
    let mode = v:event.new_mode
    if mode ==? 'i'
        " echo('insert mode')
        hi ModeMsg guibg=orange ctermbg=lightred
    elseif mode =~? '[rR]'
        " echo('replace mode')
        hi ModeMsg guibg=#e454ba ctermbg=magenta
    elseif mode =~# '[vV\x16]'
        " echo('visual mode')
        hi ModeMsg guibg=#e454ba ctermbg=magenta
    else
        " echo('other')
        hi ModeMsg guibg=orange ctermbg=lightred
    endif
endfunction 
"}}}


