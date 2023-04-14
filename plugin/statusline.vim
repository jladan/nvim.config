"Fancy status line carried over from years ago

let g:warn_root = 0
" Fancy status line {{{
" TODO fix the colors
function! MyStatusLine(mode)
    if win_gettype() == 'preview'
        return ""
    end
    let statusline=""
    if a:mode == 'Enter'
        let statusline.="%1*"
    else
        let statusline.="%0*"
    endif
    if g:warn_root
        let statusline.="ROOT"
    end
    let statusline.="\(%n\)\ %f\ "
    let statusline.="%2*%m"
    let statusline.="%r%*"
    let statusline .= "\ (%l/%L,\ %c)\ %P%=%h%w\ %y\ [%{&encoding}:%{&fileformat}]\ \ "
    return statusline
endfunction

augroup statusline
    au WinEnter * setlocal statusline=%{%MyStatusLine('Enter')%}
    au WinLeave * setlocal statusline=%{%MyStatusLine('Leave')%}
augroup END

set statusline=%!MyStatusLine('Enter')

function! InsertStatuslineColor(mode)
  if a:mode == 'i'
    hi StatColor guibg=orange ctermbg=lightred
  elseif a:mode == 'r'
    hi StatColor guibg=#e454ba ctermbg=magenta
  elseif a:mode == 'v'
    hi StatColor guibg=#e454ba ctermbg=magenta
  else
    hi StatColor guibg=red ctermbg=red
  endif
endfunction 
"}}}


