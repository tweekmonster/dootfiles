augroup vimrc_whitespace
  autocmd! BufWritePre * if empty(&l:buftype) && !exists('b:dont_strip_ws') | %s/\s\+$//e | endif
augroup END
