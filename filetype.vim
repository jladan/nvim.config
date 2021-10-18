" Added filetypes, like tsv
if exists("did_load_filetypes")
    finish
endif

augroup filetypedetect
    au! BufRead,BufNewFile *.tsv    setfiletype tsv
augroup end
