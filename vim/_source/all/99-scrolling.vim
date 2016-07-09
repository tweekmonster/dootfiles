nnoremap <left> 3zh
nnoremap <right> 3zl
xnoremap <left> 3zh
xnoremap <right> 3zl

function! s:scroll(keys) abort
  echo v:count
  silent! call repeat#set(a:keys, v:count1)
  execute 'normal! '.v:count1.a:keys
endfunction

nnoremap <silent> zh :<c-u>call <sid>scroll('zh')<cr>
nnoremap <silent> zl :<c-u>call <sid>scroll('zl')<cr>
nnoremap <silent> zH :<c-u>call <sid>scroll('zH')<cr>
nnoremap <silent> zL :<c-u>call <sid>scroll('zL')<cr>
