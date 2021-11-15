" Added filetypes, like tsv
if exists("did_load_filetypes")
    finish
endif

augroup filetypedetect
    au! BufRead,BufNewFile *.tsv    setfiletype tsv
augroup end

augroup tsv
    au  BufEnter    *.tsv   set virtualedit=all
    au  BufLeave    *.tsv   set virtualedit=""
augroup end
