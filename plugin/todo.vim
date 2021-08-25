" Idea for process:
" 1. search for all instances of xxx, todo, fixme, comebak, etc.
" 2. Check the syntax type [synIDattr(synIDtrans(synID(line("."), col("."), 1)), "fg") should evaluate to Todo]
" 3. Add any valid matches to either quickfix or local list
"
" This could be made much better if we had full textprop implementation in Vim 8.2

" The regular searchpos function only finds the next value. Instead, I could
" use lvimgrep to create a local list, and getloclist() to check the matches
" and remove false-positives.
