setlocal colorcolumn= nonumber

if &l:conceallevel == 0
  setlocal conceallevel=2
endif

let s:list = getloclist(0)
let b:is_loc = !empty(s:list)

if !b:is_loc
  let s:list = getqflist()
  if empty(s:list)
    unlet! s:list
    finish
  endif
else
  let b:src_buf = s:list[0].bufnr
endif

setlocal winfixheight
let s:size = min([15, max([5, len(s:list)])])
execute 'resize' s:size
let &winheight = s:size

unlet! s:list
unlet! s:size

if !exists('b:src_buf') && !b:is_loc
  wincmd J
endif

function! s:select() abort
  let g:_qf_win = win_getid()
  execute "normal! \<cr>"
  call win_gotoid(g:_qf_win)
  unlet! g:_qf_win
  redraw
endfunction

nnoremap <silent><buffer> q :<c-u>quit<cr>
nnoremap <silent><buffer> ,p :<c-u>let &l:conceallevel = &l:conceallevel ? 0 : 2<cr>
nnoremap <silent><buffer> <cr> :call <sid>select()<cr>
