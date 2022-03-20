" Modify the section jumps to work in latex
" inspired by Learn Vimscript the hard way
" [https://learnvimscriptthehardway.stevelosh.com/chapters/51.html]

function! s:NextSection(type, backwards, visual)
    if a:visual
        normal! gv
    endif

    if a:backwards
        let dir = '?'
    else
        let dir = '/'
    endif

    if a:type == 1
        let pattern = '\v\\(sub)*section\**\{'
    else
        let pattern = '\v\\begin\{(table\**|figure\**)\}'
    endif

    execute 'silent normal! ' . dir . pattern . "\r"
endfunction

" Find section headings
noremap <script> <buffer> <silent> [[
        \ :call <SID>NextSection(1, 1, 0)<cr>
noremap <script> <buffer> <silent> ]]
        \ :call <SID>NextSection(1, 0, 0)<cr>

" Next table or figure
noremap <script> <buffer> <silent> []
        \ :call <SID>NextSection(2, 1, 0)<cr>
noremap <script> <buffer> <silent> ][
        \ :call <SID>NextSection(2, 0, 0)<cr>

" Repeat for visual mode
vnoremap <script> <buffer> <silent> [[
        \ :<c-u>call <SID>NextSection(1, 1, 1)<cr>
vnoremap <script> <buffer> <silent> ]]
        \ :<c-u>call <SID>NextSection(1, 0, 1)<cr>
vnoremap <script> <buffer> <silent> []
        \ :<c-u>call <SID>NextSection(2, 1, 1)<cr>
vnoremap <script> <buffer> <silent> ][
        \ :<c-u>call <SID>NextSection(2, 0, 1)<cr>


