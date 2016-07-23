" Prevent the terminal from taking the window with it when it closes.
"
" The last two screens worth of text is stored in register `t`
function! s:termclose() abort
  let first = max([1, line('w0') - winheight(0)])
  call setreg('t', getline(first, line('$')), 'V')
  execute 'autocmd BufWinLeave <buffer> split' expand('#')
endfunction

function! s:tmuxnav(dir) abort
  let b:_tmuxnav = 1
  let buf = bufnr('%')
  execute 'TmuxNavigate'.a:dir

  if bufnr('%') == buf
    " Buffer didn't actually change.
    startinsert
  endif
endfunction

function! s:termopen() abort
  setlocal nospell
  tnoremap <silent><buffer> <m-h> <c-\><c-n>:<c-u>call <sid>tmuxnav('Left')<cr>
  tnoremap <silent><buffer> <m-j> <c-\><c-n>:<c-u>call <sid>tmuxnav('Down')<cr>
  tnoremap <silent><buffer> <m-k> <c-\><c-n>:<c-u>call <sid>tmuxnav('Up')<cr>
  tnoremap <silent><buffer> <m-l> <c-\><c-n>:<c-u>call <sid>tmuxnav('Right')<cr>

  autocmd BufEnter <buffer>
        \ if exists('b:_tmuxnav') |
        \   unlet! b:_tmuxnav |
        \   startinsert |
        \ endif
endfunction

augroup vimrc_term
  autocmd!
  autocmd TermOpen * call s:termopen()
  autocmd TermClose *:$SHELL,*:\$SHELL call s:termclose()
augroup END
