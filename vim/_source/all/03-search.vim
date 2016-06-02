" Removes the search highlight on insert mode and restores it in normal mode
function! s:toggle_highlight()
  if exists('b:last_hlsearch')
    let &l:hlsearch = b:last_hlsearch
    unlet b:last_hlsearch
  elseif &l:hlsearch
    let b:last_hlsearch = &l:hlsearch
    setlocal nohlsearch
  endif
endfunction

augroup vimrc_search
  autocmd!
  autocmd InsertEnter * call s:toggle_highlight()
  autocmd InsertLeave * call s:toggle_highlight()
augroup END
