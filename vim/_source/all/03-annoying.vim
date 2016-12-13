" General annoying shit

highlight default link WrongTab Error

function! s:highlight_wrong_tabs() abort
  if &l:filetype != 'help'
    return
  endif

  silent! syntax clear WrongTab
  let pat = '^ \+'
  if &l:expandtab
    let pat = '^\t\+'
  endif

  execute 'syntax match WrongTab #'.pat.'# containedin=ALL'
endfunction

augroup vimrc_annoying
  autocmd!
  autocmd VimEnter * set visualbell t_vb=
  autocmd GUIEnter * set visualbell t_vb=
  autocmd Syntax * call s:highlight_wrong_tabs()

  " This makes it so Python documentation buffers go away
  autocmd BufWinEnter '__doc__' setlocal bufhidden=delete
  " autocmd BufWinEnter,SessionLoadPost * silent! %foldopen!
augroup END
