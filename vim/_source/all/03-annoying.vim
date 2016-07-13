" General annoying shit
augroup vimrc_annoying
  autocmd!
  autocmd VimEnter * set visualbell t_vb=
  autocmd GUIEnter * set visualbell t_vb=

  " This makes it so Python documentation buffers go away
  autocmd BufWinEnter '__doc__' setlocal bufhidden=delete
  autocmd BufWinEnter,SessionLoadPost * silent! %foldopen!
augroup END
