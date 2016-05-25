" Removes the search highlight on insert mode and restores it in normal mode
function! s:hide_highlight(b)
  if a:b
    let b:last_search = @/
    let @/ = ""
  else
    if exists('b:last_search')
      let @/ = b:last_search
      unlet b:last_search
    endif
  endif
endfunction

augroup vimrc_autohide_search
  autocmd!
  autocmd InsertEnter * :call s:hide_highlight(1)
  autocmd InsertLeave * :call s:hide_highlight(0)
augroup END
