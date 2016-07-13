cnoremap <c-p> <up>

function! s:setup() abort
  " <c-p> and <c-n> already move up and down.  This overrides the other
  " mapping for j -> gj and k -> gk.
  nnoremap <buffer> <c-p> k
  nnoremap <buffer> <c-n> j
  " Accidentally opening the command window is annoying as hell, and macros
  " aren't useful in them anyways.
  nnoremap <silent><buffer> q :<c-u>q<cr>
endfunction

augroup vimrc_commandline
  autocmd!
  autocmd CmdwinEnter * call <sid>setup()
augroup END
