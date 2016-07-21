" Prevent the terminal from taking the window with it when it closes.  Uses a
" separate function to avoid double execute quoting.
"
" The last two screens worth of text is stored in register `t`
function! s:termclose() abort
  let first = max([1, line('w0') - winheight(0)])
  call setreg('t', getline(first, line('$')), 'V')
  execute 'autocmd BufWinLeave <buffer> split' expand('#')
endfunction

augroup vimrc_term
  autocmd!
  execute 'autocmd TermClose *:'.$SHELL.' call s:termclose()'
augroup END
