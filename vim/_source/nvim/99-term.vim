" Prevent the terminal from taking the window with it when it closes.
"
" The last two screens worth of text is stored in register `t`
function! s:termclose() abort
  let first = max([1, line('w0') - winheight(0)])
  call setreg('t', getline(first, line('$')), 'V')
  execute 'autocmd BufWinLeave <buffer> split' expand('#')
endfunction

augroup vimrc_term
  autocmd!
  autocmd TermOpen * setlocal nospell
  autocmd TermClose *:$SHELL call s:termclose()
augroup END
