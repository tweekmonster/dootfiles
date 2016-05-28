function! s:setup() abort
  nnoremap <silent> ]t :tabnext<cr>
  nnoremap <silent> [t :tabprev<cr>
endfunction

augroup vimrc_unimpaired
  autocmd!
  autocmd VimEnter * call <sid>setup()
augroup END
