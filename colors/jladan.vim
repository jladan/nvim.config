
" Name:     jladan's vim colorscheme
" Author:   John Ladan (based heavily on Solarized)
" URL:      
" License:  OSI approved MIT license (see end of this file)
" Created:  Oct 29, 2013
" Modified: 2011 May 05
"
" Usage "{{{
"
" ---------------------------------------------------------------------
" ABOUT:
" ---------------------------------------------------------------------
" Solarized is a carefully designed selective contrast colorscheme with dual
" light and dark modes that runs in both GUI, 256 and 16 color modes.
"
" See the homepage above for screenshots and details.
"
" ---------------------------------------------------------------------
" OPTIONS:
" ---------------------------------------------------------------------
" See the "solarized.txt" help file included with this colorscheme (in the 
" "doc" subdirectory) for information on options, usage, the Toggle Background 
" function and more. If you have already installed Solarized, this is available 
" from the Solarized menu and command line as ":help solarized"
"
" ---------------------------------------------------------------------
" INSTALLATION:
" ---------------------------------------------------------------------
" Two options for installation: manual or pathogen
"
" MANUAL INSTALLATION OPTION:
" ---------------------------------------------------------------------
"
" 1.  Download the solarized distribution (available on the homepage above)
"     and unarchive the file.
" 2.  Move `solarized.vim` to your `.vim/colors` directory.
" 3.  Move each of the files in each subdirectories to the corresponding .vim
"     subdirectory (e.g. autoload/togglebg.vim goes into your .vim/autoload 
"     directory as .vim/autoload/togglebg.vim).
"
" RECOMMENDED PATHOGEN INSTALLATION OPTION:
" ---------------------------------------------------------------------
"
" 1.  Download and install Tim Pope's Pathogen from:
"     https://github.com/tpope/vim-pathogen
"
" 2.  Next, move or clone the `vim-colors-solarized` directory so that it is
"     a subdirectory of the `.vim/bundle` directory.
"
"     a. **clone with git:**
"
"       $ cd ~/.vim/bundle
"       $ git clone git://github.com/altercation/vim-colors-solarized.git
"
"     b. **or move manually into the pathogen bundle directory:**
"         In the parent directory of vim-colors-solarized:
"
"         $ mv vim-colors-solarized ~/.vim/bundle/
"
" MODIFY VIMRC:
"
" After either Option 1 or Option 2 above, put the following two lines in your
" .vimrc:
"
"     syntax enable
"     set background=dark
"     colorscheme solarized
"
" or, for the light background mode of Solarized:
"
"     syntax enable
"     set background=light
"     colorscheme solarized
"
" I like to have a different background in GUI and terminal modes, so I can use
" the following if-then. However, I find vim's background autodetection to be
" pretty good and, at least with MacVim, I can leave this background value
" assignment out entirely and get the same results.
"
"     if has('gui_running')
"       set background=light
"     else
"       set background=dark
"     endif
"
" See the Solarized homepage at http://ethanschoonover.com/solarized for
" screenshots which will help you select either the light or dark background.
"
" ---------------------------------------------------------------------
" COLOR VALUES
" ---------------------------------------------------------------------
" Download palettes and files from: http://ethanschoonover.com/solarized
"
" L\*a\*b values are canonical (White D65, Reference D50), other values are
" matched in sRGB space.
"
" SOLARIZED HEX     16/8 TERMCOL  XTERM/HEX   L*A*B      sRGB        HSB
" --------- ------- ---- -------  ----------- ---------- ----------- -----------
" base03    #002b36  8/4 brblack  234 #1c1c1c 15 -12 -12   0  43  54 193 100  21
" base02    #073642  0/4 black    235 #262626 20 -12 -12   7  54  66 192  90  26
" base01    #586e75 10/7 brgreen  240 #4e4e4e 45 -07 -07  88 110 117 194  25  46
" base00    #657b83 11/7 bryellow 241 #585858 50 -07 -07 101 123 131 195  23  51
" base0     #839496 12/6 brblue   244 #808080 60 -06 -03 131 148 150 186  13  59
" base1     #93a1a1 14/4 brcyan   245 #8a8a8a 65 -05 -02 147 161 161 180   9  63
" base2     #eee8d5  7/7 white    254 #d7d7af 92 -00  10 238 232 213  44  11  93
" base3     #fdf6e3 15/7 brwhite  230 #ffffd7 97  00  10 253 246 227  44  10  99
" yellow    #b58900  3/3 yellow   136 #af8700 60  10  65 181 137   0  45 100  71
" orange    #cb4b16  9/3 brred    166 #d75f00 50  50  55 203  75  22  18  89  80
" red       #dc322f  1/1 red      160 #d70000 50  65  45 220  50  47   1  79  86
" magenta   #d33682  5/5 magenta  125 #af005f 50  65 -05 211  54 130 331  74  83
" violet    #6c71c4 13/5 brmagenta 61 #5f5faf 50  15 -45 108 113 196 237  45  77
" blue      #268bd2  4/4 blue      33 #0087ff 55 -10 -45  38 139 210 205  82  82
" cyan      #2aa198  6/6 cyan      37 #00afaf 60 -35 -05  42 161 152 175  74  63
" green     #859900  2/2 green     64 #5f8700 60 -20  65 133 153   0  68 100  60
"
" ---------------------------------------------------------------------
" COLORSCHEME HACKING
" ---------------------------------------------------------------------
"
" Useful commands for testing colorschemes:
" :source $VIMRUNTIME/syntax/hitest.vim
" :help highlight-groups
" :help cterm-colors
" :help group-name
"
" Useful links for developing colorschemes:
" http://www.vim.org/scripts/script.php?script_id=2937
" http://vimcasts.org/episodes/creating-colorschemes-for-vim/
" http://www.frexx.de/xterm-256-notes/"
"
" }}}
" Colorscheme initialization "{{{
" ---------------------------------------------------------------------
hi clear
if exists("syntax_on")
  syntax reset
endif
let colors_name = "jladan"

"}}}
" Color Pallette"{{{
" ---------------------------------------------------------------------
"

let s:bg          = "Black"
let s:fg          = "grey"
let s:base03      = "Black"
let s:base02      = "Black"
if &t_Co == 88
    let s:base01      = "80"
    let s:base00      = "81"
    let s:base0       = "82"
    let s:base1       = "83"
    let s:base2       = "86"
elseif &t_Co == 256
    " TODO find out good grey values in 256-colour mode
    let s:base01      = "darkgrey"
    let s:base00      = "darkgrey"
    let s:base0       = "darkgrey"
    let s:base1       = "grey"
    let s:base2       = "white"
else " for a 16-color terminal, or default
    let s:base01      = "darkgrey"
    let s:base00      = "darkgrey"
    let s:base0       = "darkgrey"
    let s:base1       = "grey"
    let s:base2       = "white"
endif
let s:base3       = "White"
let s:yellow      = "Yellow"
let s:orange      = "Red"
let s:red         = "DarkRed"
let s:violet      = "DarkMagenta"
let s:magenta     = "Magenta"
let s:blue        = "DarkBlue"
let s:cyan        = "Cyan"
let s:green       = "DarkGreen"
let s:lgreen      = "Green"

let s:gbg          = "#000000"
let s:gfg          = "#bdc3c7"
let s:gbase03      = "#000000"
let s:gbase02      = "#000000"
let s:gbase01      = "#4b4b4b"
let s:gbase00      = "#323232"
let s:gbase0       = "#4b4b4b"
let s:gbase1       = "#646464"
let s:gbase2       = "#b3b3b3"
let s:gbase3       = "#ecf0f1"
let s:gyellow      = "#f1c40f"
let s:gorange      = "#e74c3c"
let s:gred         = "#c0392b"
let s:gviolet      = "#8e44ad"
let s:gmagenta     = "#9b59b6"
let s:gblue        = "#2980b9"
let s:gcyan        = "#1abc9c"
let s:ggreen       = "#27ae60"
let s:glgreen      = "#2ecc71"
"}}}
" Formatting options and null values for passthrough effect "{{{
" ---------------------------------------------------------------------
let s:none            = "NONE"
let s:none            = "NONE"
let s:t_none          = "NONE"
let s:n               = "NONE"
let s:c               = ",undercurl"
let s:r               = ",reverse"
let s:s               = ",standout"
let s:ou              = ""
let s:ob              = ""

"}}}
" Alternate light scheme "{{{
" ---------------------------------------------------------------------
if &background == "light"
    let s:bg          = "white"
    let s:fg          = "black"
    " TODO should probably check number of colours for light scheme as well
    let s:base03      = "lightgrey"
    let s:base02      = "darkgrey"
    let s:base01      = "83"
    let s:base00      = "82"
    let s:base0       = "black"
    let s:base1       = "80"
    let s:base2       = "black"
    let s:base3       = "black"
    let s:green       = "DarkGreen"
    let s:red         = "red"
    let s:yellow      = "brown"

    let s:gbg          = "#ecf0f1"
    let s:gfg          = "#000000"
    let s:gbase03      = "#bdc3c7"
    let s:gbase02      = "#bdc3c7"
    let s:gbase01      = "#646464"
    let s:gbase00      = "#4b4b4b"
    let s:gbase0       = "#323232"
    let s:gbase1       = "#191919"
    let s:gbase2       = "#000000"
    let s:gbase3       = "#000000"
    let s:ggreen       = "#27ae60"
    let s:gred         = "#e74c3c"
    let s:gyellow      = "#f39c12"
endif

let s:back        = s:bg
let s:front       = s:fg
let s:gback        = s:gbg
let s:gfront       = s:gfg
"}}}
" Bold and underline formatting "{{{
" ---------------------------------------------------------------------
let s:b           = ",bold"
let s:bb          = ""
if ( &term == "cygwin") + has("win32")
    let s:u           = ""
    let s:i           = ""
else
    let s:u           = ",underline"
    let s:i           = ",italic"
endif
"}}}
" Highlighting primitives"{{{
" ---------------------------------------------------------------------

exe "let s:bg_none      = ' ctermbg=".s:none   ." guibg=".s:none."'"
exe "let s:bg_back      = ' ctermbg=".s:back   ." guibg=".s:gback."'"
exe "let s:bg_front     = ' ctermbg=".s:front  ." guibg=".s:gfront."'"
exe "let s:bg_base03    = ' ctermbg=".s:base03 ." guibg=".s:gbase03."'"
exe "let s:bg_base02    = ' ctermbg=".s:base02 ." guibg=".s:gbase02."'"
exe "let s:bg_base00    = ' ctermbg=".s:base00 ." guibg=".s:gbase00."'"
exe "let s:bg_base0     = ' ctermbg=".s:base0  ." guibg=".s:gbase0."'"
exe "let s:bg_base1     = ' ctermbg=".s:base1  ." guibg=".s:gbase1."'"
exe "let s:bg_base2     = ' ctermbg=".s:base2  ." guibg=".s:gbase2."'"
exe "let s:bg_base3     = ' ctermbg=".s:base3  ." guibg=".s:gbase3."'"
exe "let s:bg_green     = ' ctermbg=".s:green  ." guibg=".s:ggreen."'"
exe "let s:bg_lgreen    = ' ctermbg=".s:lgreen ." guibg=".s:glgreen."'"
exe "let s:bg_yellow    = ' ctermbg=".s:yellow ." guibg=".s:gyellow."'"
exe "let s:bg_orange    = ' ctermbg=".s:orange ." guibg=".s:gorange."'"
exe "let s:bg_red       = ' ctermbg=".s:red    ." guibg=".s:gred."'"
exe "let s:bg_magenta   = ' ctermbg=".s:magenta." guibg=".s:gmagenta."'"
exe "let s:bg_violet    = ' ctermbg=".s:violet ." guibg=".s:gviolet."'"
exe "let s:bg_blue      = ' ctermbg=".s:blue   ." guibg=".s:gblue."'"
exe "let s:bg_cyan      = ' ctermbg=".s:cyan   ." guibg=".s:gcyan."'"

exe "let s:fg_none      = ' ctermfg=".s:none   ." guifg=".s:none."'"
exe "let s:fg_back      = ' ctermfg=".s:back   ." guifg=".s:gback."'"
exe "let s:fg_front     = ' ctermfg=".s:front  ." guifg=".s:gfront."'"
exe "let s:fg_base03    = ' ctermfg=".s:base03 ." guifg=".s:gbase03."'"
exe "let s:fg_base02    = ' ctermfg=".s:base02 ." guifg=".s:gbase02."'"
exe "let s:fg_base01    = ' ctermfg=".s:base01 ." guifg=".s:gbase01."'"
exe "let s:fg_base00    = ' ctermfg=".s:base00 ." guifg=".s:gbase00."'"
exe "let s:fg_base0     = ' ctermfg=".s:base0  ." guifg=".s:gbase0."'"
exe "let s:fg_base1     = ' ctermfg=".s:base1  ." guifg=".s:gbase1."'"
exe "let s:fg_base2     = ' ctermfg=".s:base2  ." guifg=".s:gbase2."'"
exe "let s:fg_base3     = ' ctermfg=".s:base3  ." guifg=".s:gbase3."'"
exe "let s:fg_green     = ' ctermfg=".s:green  ." guifg=".s:ggreen."'"
exe "let s:fg_lgreen     = ' ctermfg=".s:lgreen  ." guifg=".s:glgreen."'"
exe "let s:fg_yellow    = ' ctermfg=".s:yellow ." guifg=".s:gyellow."'"
exe "let s:fg_orange    = ' ctermfg=".s:orange ." guifg=".s:gorange."'"
exe "let s:fg_red       = ' ctermfg=".s:red    ." guifg=".s:gred."'"
exe "let s:fg_magenta   = ' ctermfg=".s:magenta." guifg=".s:gmagenta."'"
exe "let s:fg_violet    = ' ctermfg=".s:violet ." guifg=".s:gviolet."'"
exe "let s:fg_blue      = ' ctermfg=".s:blue   ." guifg=".s:gblue."'"
exe "let s:fg_cyan      = ' ctermfg=".s:cyan   ." guifg=".s:gcyan."'"

exe "let s:fmt_none     = ' cterm=NONE".          " term=NONE".    " gui=NONE".   "'"
exe "let s:fmt_bold     = ' cterm=NONE".s:b.      " term=NONE".s:b." gui=NONE".s:b."'"
exe "let s:fmt_bldi     = ' cterm=NONE".s:b.      " term=NONE".s:b." gui=NONE".s:b.s:i."'"
exe "let s:fmt_undr     = ' cterm=NONE".s:u.      " term=NONE".s:u." gui=NONE".s:u."'"
exe "let s:fmt_undb     = ' cterm=NONE".s:u.s:b.  " term=NONE".s:u.s:b." gui=NONE".s:u.s:b."'"
exe "let s:fmt_undi     = ' cterm=NONE".s:u.      " term=NONE".s:u." gui=NONE".s:u.s:i."'"
exe "let s:fmt_uopt     = ' cterm=NONE".s:ou.     " term=NONE".s:ou." gui=NONE".s:ou."'"
exe "let s:fmt_curl     = ' cterm=NONE".s:c.      " term=NONE".s:c." gui=NONE".s:c."'"
exe "let s:fmt_ital     = ' cterm=NONE".s:i.      " term=NONE".s:i." gui=NONE".s:i."'"
exe "let s:fmt_stnd     = ' cterm=NONE".s:s.      " term=NONE".s:s." gui=NONE".s:s."'"
exe "let s:fmt_revr     = ' cterm=NONE".s:r.      " term=NONE".s:r." gui=NONE".s:r."'"
exe "let s:fmt_revb     = ' cterm=NONE".s:r.s:b.  " term=NONE".s:r.s:b." gui=NONE".s:r.s:b."'"
" revbb (reverse bold for bright colors) is only set to actual bold in low 
" color terminals (t_co=8, such as OS X Terminal.app) and should only be used 
" with colors 8-15.
exe "let s:fmt_revbb    = ' cterm=NONE".s:r.s:bb.   " term=NONE".s:r.s:bb." gui=NONE".s:r.s:bb."'"
exe "let s:fmt_revbbu   = ' cterm=NONE".s:r.s:bb.s:u." term=NONE".s:r.s:bb.s:u." gui=NONE".s:r.s:bb.s:u."'"

"}}}
" Basic highlighting"{{{
" ---------------------------------------------------------------------
" note that link syntax to avoid duplicate configuration doesn't work with the
" exe compiled formats

exe "hi! Normal"         .s:fmt_none   .s:fg_front  .s:bg_back

exe "hi! Comment"        .s:fmt_ital   .s:fg_blue  .s:bg_none
"       *Comment         any comment

exe "hi! Constant"       .s:fmt_none   .s:fg_violet   .s:bg_none
"       *Constant        any constant
"        String          a string constant: "this is a string"
"        Character       a character constant: 'c', '\n'
"        Number          a number constant: 234, 0xff
"        Boolean         a boolean constant: TRUE, false
"        Float           a floating point constant: 2.3e10

exe "hi! Identifier"     .s:fmt_none   .s:fg_cyan   .s:bg_none
"       *Identifier      any variable name
"        Function        function name (also: methods for classes)
"
exe "hi! Statement"      .s:fmt_none   .s:fg_yellow  .s:bg_none
"       *Statement       any statement
"        Conditional     if, then, else, endif, switch, etc.
"        Repeat          for, do, while, etc.
"        Label           case, default, etc.
"        Operator        "sizeof", "+", "*", etc.
"        Keyword         any other keyword
"        Exception       try, catch, throw

exe "hi! PreProc"        .s:fmt_none   .s:fg_blue .s:bg_none
"       *PreProc         generic Preprocessor
"        Include         preprocessor #include
"        Define          preprocessor #define
"        Macro           same as Define
"        PreCondit       preprocessor #if, #else, #endif, etc.

exe "hi! Type"           .s:fmt_none   .s:fg_lgreen .s:bg_none
"       *Type            int, long, char, etc.
"        StorageClass    static, register, volatile, etc.
"        Structure       struct, union, enum, etc.
"        Typedef         A typedef

exe "hi! Special"        .s:fmt_none   .s:fg_orange    .s:bg_none
"       *Special         any special symbol
"        SpecialChar     special character in a constant
"        Tag             you can use CTRL-] on this
"        Delimiter       character that needs attention
"        SpecialComment  special things inside a comment
"        Debug           debugging statements

exe "hi! Underlined"     .s:fmt_undr   .s:fg_violet .s:bg_none
"       *Underlined      text that stands out, HTML links

exe "hi! Ignore"         .s:fmt_none   .s:fg_none   .s:bg_none
"       *Ignore          left blank, hidden  |hl-Ignore|

exe "hi! Error"          .s:fmt_bold   .s:fg_back    .s:bg_red
"       *Error           any erroneous construct

exe "hi! Todo"           .s:fmt_bold   .s:fg_magenta .s:bg_none
"       *Todo            anything that needs extra attention; mostly the
"                        keywords TODO FIXME and XXX
"
"}}}
" Extended highlighting "{{{
" ---------------------------------------------------------------------
exe "hi! SpecialKey"     .s:fmt_bold   .s:fg_base00 .s:bg_base02
exe "hi! NonText"        .s:fmt_bold   .s:fg_base00 .s:bg_none
exe "hi! Directory"      .s:fmt_none   .s:fg_blue   .s:bg_none
exe "hi! ErrorMsg"       .s:fmt_revr   .s:fg_red    .s:bg_none
exe "hi! IncSearch"      .s:fmt_stnd   .s:fg_orange .s:bg_none
exe "hi! Search"         .s:fmt_revr   .s:fg_yellow .s:bg_none
exe "hi! MoreMsg"        .s:fmt_none   .s:fg_blue   .s:bg_none
exe "hi! ModeMsg"        .s:fmt_none   .s:fg_blue   .s:bg_none
exe "hi! LineNr"         .s:fmt_none   .s:fg_base01 .s:bg_base02
exe "hi! CursorLineNr"   .s:fmt_none   .s:fg_yellow .s:bg_base02
exe "hi! Question"       .s:fmt_bold   .s:fg_cyan   .s:bg_none
exe "hi! VertSplit"      .s:fmt_revbb  .s:fg_base00 .s:bg_base02
exe "hi! Title"          .s:fmt_bold   .s:fg_orange .s:bg_none
exe "hi! VisualNOS"      .s:fmt_stnd   .s:fg_none   .s:bg_base02 .s:fmt_revbb
exe "hi! WarningMsg"     .s:fmt_bold   .s:fg_red    .s:bg_none
exe "hi! WildMenu"       .s:fmt_none   .s:fg_base2  .s:bg_base02 .s:fmt_revbb
exe "hi! Folded"         .s:fmt_undb   .s:fg_base0  .s:bg_none
exe "hi! FoldColumn"     .s:fmt_none   .s:fg_base0  .s:bg_base02
exe "hi! DiffAdd"        .s:fmt_none   .s:fg_green  .s:bg_base02 
exe "hi! DiffChange"     .s:fmt_none   .s:fg_yellow .s:bg_base02 
exe "hi! DiffDelete"     .s:fmt_none   .s:fg_red    .s:bg_base02
exe "hi! DiffText"       .s:fmt_none   .s:fg_blue   .s:bg_base02 
exe "hi! SignColumn"     .s:fmt_none   .s:fg_base0
exe "hi! Conceal"        .s:fmt_none   .s:fg_blue   .s:bg_none
exe "hi! SpellBad"       .s:fmt_curl   .s:fg_none   .s:bg_none    
exe "hi! SpellCap"       .s:fmt_curl   .s:fg_none   .s:bg_none    
exe "hi! SpellRare"      .s:fmt_curl   .s:fg_none   .s:bg_none    
exe "hi! SpellLocal"     .s:fmt_curl   .s:fg_none   .s:bg_none    
exe "hi! Pmenu"          .s:fmt_none   .s:fg_base0  .s:bg_base02  .s:fmt_revbb
exe "hi! PmenuSel"       .s:fmt_none   .s:fg_base01 .s:bg_base2   .s:fmt_revbb
exe "hi! PmenuSbar"      .s:fmt_none   .s:fg_base2  .s:bg_base0   .s:fmt_revbb
exe "hi! PmenuThumb"     .s:fmt_none   .s:fg_base0  .s:bg_base03  .s:fmt_revbb
exe "hi! TabLine"        .s:fmt_undr   .s:fg_green  .s:bg_base02  
exe "hi! TabLineFill"    .s:fmt_undr   .s:fg_base0  .s:bg_base02  
exe "hi! TabLineSel"     .s:fmt_undr   .s:fg_lgreen .s:bg_base02   .s:fmt_revbbu
exe "hi! Cursor"         .s:fmt_none   .s:fg_base03 .s:bg_base0
hi! link lCursor Cursor
exe "hi! MatchParen"     .s:fmt_bold   .s:fg_back    .s:bg_cyan

"}}}
" Statusline colours "{{{
exe "hi! User0"          .s:fmt_none   .s:fg_back   .s:bg_front
exe "hi! User1"          .s:fmt_none   .s:fg_back   .s:bg_green
exe "hi! User2"          .s:fmt_none   .s:fg_back   .s:bg_red
"}}}
" tex highlighting "{{{
" ---------------------------------------------------------------------
"exe "hi! texStatement"          . s:fg_cyan   .s:bg_back   .s:fmt_none
exe "hi! texMath"                . s:fg_violet .s:bg_none   .s:fmt_none
"exe "hi! texRefLabel"    . s:fg_yellow .s:bg_back   .s:fmt_none
"}}}
" Highlight Trailing Space {{{
" Experimental: Different highlight when on cursorline
if !exists("g:hitrail")
    let g:hitrail=0
endif
function! s:HiTrail()
    if g:hitrail==0
        hi! clear TrailingSpace
    else
        syn match TrailingSpace "\s*$" containedin=ALL
        exe "hi! TrailingSpace " .s:fmt_none .s:fg_none .s:bg_red
    endif
endfunction
augroup HiTrail
    autocmd!
    if g:hitrail==1
        autocmd! Syntax * call s:HiTrail()
        autocmd! ColorScheme * if g:colors_name == "jladan" | call s:HiTrail() | else | augroup! s:HiTrail | endif
    endif
augroup END
" }}}
" Cursor colors "{{{
if !( (&term=="cygwin") + has("win32") )
    " use an orange cursor in insert mode
    let &t_SI = "\<Esc>]12;sky blue\x7"
    " use a red cursor otherwise
    let &t_EI = "\<Esc>]12;light salmon\x7"
    silent !echo -ne "\033]12;light salmon\007"
    " reset cursor when vim exits
    autocmd VimLeave * silent !echo -ne "\033]112\007"
endif
""}}}
" License "{{{
" ---------------------------------------------------------------------
"
" Copyright (c) 2011 Ethan Schoonover
"
" Permission is hereby granted, free of charge, to any person obtaining a copy
" of this software and associated documentation files (the "Software"), to deal
" in the Software without restriction, including without limitation the rights
" to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
" copies of the Software, and to permit persons to whom the Software is
" furnished to do so, subject to the following conditions:
"
" The above copyright notice and this permission notice shall be included in
" all copies or substantial portions of the Software.
"
" THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
" IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
" FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
" AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
" LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
" OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
" THE SOFTWARE.
"
" vim:foldmethod=marker:foldlevel=0
"}}}
