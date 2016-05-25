let g:gitgutter_sign_column_always = 1

function! s:gitgutter_refresh()
  autocmd! vimrc_gitgutter_refresh
  call gitgutter#all()
endfunction

function! s:gitgutter_prep_refresh()
  augroup vimrc_gitgutter_refresh
    autocmd!
    exec 'autocmd BufUnload ' . bufname('%') . ' call <sid>gitgutter_refresh()'
  augroup END
endfunction

augroup vimrc_gitgutter
  autocmd!
  autocmd SessionLoadPost * GitGutterAll
  autocmd BufEnter * GitGutter
  autocmd FileType gitcommit call <sid>gitgutter_prep_refresh()
augroup END
