let g:terminal_scrollback_buffer_size = 10000
" Prevent the terminal from taking the window with it when it closes.
"
" The last two screens worth of text is stored in register `t`
function! s:termclose() abort
  let first = max([1, line('w0') - winheight(0)])
  call setreg('t', getline(first, line('$')), 'V')
  if bufname('%') =~# ';#popup$'
    if exists('b:_popup_return')
      execute 'autocmd BufWinLeave <buffer> call win_gotoid('.b:_popup_return.')'
    endif
    return
  endif

  let buf = expand('#')
  if !empty(buf) && buflisted(buf) && bufnr(buf) != bufnr('%')
    execute 'autocmd BufWinLeave <buffer> split' buf
  endif
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

  augroup tmuxnav
    autocmd!
    autocmd BufEnter <buffer>
          \ if &buftype == 'terminal' && exists('b:_tmuxnav') |
          \   unlet! b:_tmuxnav |
          \   startinsert |
          \ endif
  augroup END

  if bufname('%') =~# ';#popup$'
    call s:setup_popup_term()
  endif
endfunction


augroup vimrc_term
  autocmd!
  autocmd TermOpen * call s:termopen()
  autocmd TermClose *:$SHELL,*:\$SHELL call s:termclose()
augroup END


function! s:setup_popup_term() abort
  resize 15
  setlocal winfixheight
  let b:_popup_term = 1
  autocmd! tmuxnav * <buffer>
  wincmd J
  tnoremap <buffer> <silent> <c-o> <c-\><c-n>:call <sid>popup_return()<cr>
  nnoremap <buffer> <silent> <c-o> :call <sid>popup_return()<cr>
endfunction


function! s:popup_return() abort
  if exists('b:_popup_return')
    call win_gotoid(b:_popup_return)
  else
    wincmd p
  endif
endfunction


function! s:popup_term() abort
  let cur_winid = win_getid()
  let winnr = 0
  let bufnr = 0

  for buf in range(1, bufnr('$'))
    if !bufexists(buf)
      continue
    endif

    if getbufvar(buf, '&buftype') == 'terminal' && bufname(buf) =~# ';#popup$'
      let bufnr = buf
      let winnr = bufwinnr(buf)
      break
    endif
  endfor

  if winnr > 0
    if winnr() != winnr
      call win_gotoid(win_getid(winnr))
      let b:_popup_return = cur_winid
      if !exists('b:_popup_term')
        call s:setup_popup_term()
      else
        startinsert
      endif
      return
    endif

    execute winnr 'windo close'
    call win_gotoid(cur_winid)
    return
  endif

  if bufnr > 0
    split
    execute 'buffer' bufnr
    let b:_popup_return = cur_winid
    call s:setup_popup_term()
    return
  endif

  split
  execute 'terminal' &shell ';\#popup'
  let b:_popup_return = cur_winid
endfunction

nnoremap <silent> <localleader>T :call <sid>popup_term()<cr>
