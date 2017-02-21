setlocal foldmethod=manual
nnoremap <buffer> zc zfat
nnoremap <buffer> zo zd

function! s:adjust_inner_tag() abort
  if line("'<") == line("'>")
    normal! gv
    return
  endif
  normal! gvk$oj^o
endfunction

vnoremap <buffer><silent> it it:<c-u>call <sid>adjust_inner_tag()<cr>
onoremap <buffer><silent> it :normal! vit<cr>:<c-u>call <sid>adjust_inner_tag()<cr>
