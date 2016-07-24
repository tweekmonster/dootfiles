function! s:setup() abort
  nnoremap <expr><buffer> } filter([search('\%(\_^#\?\s*\_$\)\\|\%$', 'W'), line('$')], 'v:val')[0].'G'
  nnoremap <expr><buffer> { max([1, search('\%(\_^#\?\s*\_$\)\\|\%^', 'bW')]).'G'

  if expand('%') =~# 'COMMIT_EDITMSG'
    setlocal spell
    " delete the commit message storing it in "g, and go back to Gstatus
    nnoremap <silent><buffer> q gg"gd/#<cr>:let @/=''<cr>:<c-u>wq<cr>:Gstatus<cr>:call histdel('search', -1)<cr>
    " Restore register "g
    nnoremap <silent><buffer> <leader>u gg"gP
  endif
endfunction


augroup vimrc_fugitive
  autocmd!
  autocmd FileType gitcommit call s:setup()
augroup END
