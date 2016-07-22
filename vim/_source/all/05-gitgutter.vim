let g:gitgutter_sign_column_always = 1
let g:gitgutter_override_sign_column_highlight = 0

" Aggressively update GitGutter.
" There seems to be an issue with how hunks are updated after SessionLoadPost.
" Using the timer feature, the signs will be updated for the buffer the cursor
" is in after the session script is done loading.
function! s:gg(...) abort
  if !a:0
    if exists('s:gg_timer')
      call timer_stop(s:gg_timer)
    endif

    let s:gg_timer = timer_start(500, 's:gg')
    return
  endif

  unlet! s:gg_timer
  GitGutter
endfunction

augroup vimrc_gitgutter
  autocmd!
  autocmd SessionLoadPost * call s:gg()
  autocmd BufEnter,BufWinEnter,BufReadPost * GitGutter
  autocmd FileType gitcommit autocmd BufUnload <buffer> GitGutterAll | GitGutter
augroup END
