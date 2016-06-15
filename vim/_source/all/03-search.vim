" Removes the search highlight on insert mode and restores it in normal mode
function! s:toggle_highlight()
  if exists('b:_last_search')
    let @/ = b:_last_search
    unlet b:_last_search
  else
    let b:_last_search = @/
    let @/ = ''
  endif
endfunction

augroup vimrc_search
  autocmd!
  autocmd InsertEnter * call s:toggle_highlight()
  autocmd InsertLeave * call s:toggle_highlight()
augroup END
