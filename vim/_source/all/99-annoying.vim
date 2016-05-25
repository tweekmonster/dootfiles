" General annoying shit

function! s:set_help_options()
  let runtimep = expand('$VIMRUNTIME')
  let helpp = expand('%')
  if helpp =~ '^'.runtimep || helpp =~ '^'.expand('~/.vim')
    setlocal nolist norelativenumber nonumber nomodifiable readonly buftype=help noswapfile nobuflisted
    exec 'sign unplace * file='.helpp
  endif
endfunction

augroup vimrc_annoying
  autocmd!
  autocmd VimEnter * set visualbell t_vb=
  autocmd GUIEnter * set visualbell t_vb=

  autocmd FileType help nmap <buffer> q :<c-u>q<cr>
  autocmd FileType help call <sid>set_help_options()

  " This makes it so Python documentation buffers go away
  autocmd BufWinEnter '__doc__' setlocal bufhidden=delete
augroup END
