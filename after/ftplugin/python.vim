" Custom folding function for docstrings and manual marks
function! PythonFoldExpr()
    let thisline = getline(v:lnum)
    let prevline = getline(v:lnum -1 )
    " {{{,}}} marks
    if match(thisline, '{{{') >= 0
        return "a1"
    elseif match(thisline, '}}}') >=0
        return "s1"
    " Docstrings
    elseif match(thisline, '"""') >=0 
        if PythonIsDocStart(v:lnum)
            " Starts a docstring
            return "a1"
        elseif PythonIsDocStart(PythonLastQuote(v:lnum))
            " The end of a docstring
                return "s1"
        else
            return "="
        endif
    else
        return "="
    endif
endfunction

function! PythonLastQuote(lnum)
    let cl = a:lnum
    while cl > 0
        let cl -= 1
        if getline(cl) =~ '"""'
            return cl
        endif
    endwhile
    return 0
endfunction

function! PythonIsDocStart(lnum)
    let prevline = getline(a:lnum-1)
    if a:lnum == 1
        return 1
    elseif prevline =~# "^\\s*def" || prevline =~# "^\\s*class"
        return 2
    else
        return 0
    endif
endfunction

setlocal foldmethod=expr
setlocal foldexpr=nvim_treesitter#foldexpr()

let &foldlevel = max(map(range(1, line('$')), 'foldlevel(v:val)'))
