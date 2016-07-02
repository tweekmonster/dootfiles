augroup vimrc_whitespace
  autocmd! BufWritePre * if empty(&l:buftype) && !exists('b:dont_strip_ws') | %s/\s\+$//e | call histdel('search', -1) | endif
augroup END
