augroup vimrc_whitespace
  autocmd! BufWritePre *
        \ if empty(&l:buftype) && !exists('b:dont_strip_ws') |
        \   let b:_ws = winsaveview() |
        \   %s/\s\+$//e |
        \   call histdel('search', -1) |
        \   call winrestview(b:_ws) |
        \   unlet! b:_ws |
        \ endif
augroup END
