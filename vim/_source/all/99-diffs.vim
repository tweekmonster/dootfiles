" Switches back to the fugitive buffer after closing a diff.  Also swaps in
" the original file if it was closed during diff mode.
function! s:diff_close() abort
  if !&diff || !exists('w:fugitive_diff_restore')
    return
  endif

  if &bufhidden != 'delete'
    for i in range(1, winnr('$'))
      if !empty(getwinvar(i, 'fugitive_diff_restore', ''))
        execute 'noautocmd' i 'windo edit' bufname('%')
        break
      endif
    endfor
  endif

  for i in range(1, winnr('$'))
    if getwinvar(i, '&filetype', '') == 'gitcommit'
      execute 'noautocmd' i 'wincmd w'
      break
    endif
  endfor
endfunction


augroup vimrc_diff
  autocmd!
  autocmd SessionLoadPost * if &filetype == 'gitcommit' | close | endif
  autocmd SessionLoadPost */.git//* if &bufhidden == 'delete' | close | endif
  autocmd QuitPre * call s:diff_close()
augroup END
