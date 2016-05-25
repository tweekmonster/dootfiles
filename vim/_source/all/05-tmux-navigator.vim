let g:tmux_navigator_no_mappings = 1

if has('nvim')
  nnoremap <silent> <m-h> :TmuxNavigateLeft<cr>
  nnoremap <silent> <m-j> :TmuxNavigateDown<cr>
  nnoremap <silent> <m-k> :TmuxNavigateUp<cr>
  nnoremap <silent> <m-l> :TmuxNavigateRight<cr>
else
  nnoremap <silent> <a-h> :TmuxNavigateLeft<cr>
  nnoremap <silent> <a-j> :TmuxNavigateDown<cr>
  nnoremap <silent> <a-k> :TmuxNavigateUp<cr>
  nnoremap <silent> <a-l> :TmuxNavigateRight<cr>
endif
