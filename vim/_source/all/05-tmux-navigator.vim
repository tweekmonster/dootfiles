let g:tmux_navigator_no_mappings = 1

if !has('nvim')
  execute "set <m-h>=\eh <m-j>=\ej <m-k>=\ek <m-l>=\el"
endif

nnoremap <silent> <m-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <m-j> :TmuxNavigateDown<cr>
nnoremap <silent> <m-k> :TmuxNavigateUp<cr>
nnoremap <silent> <m-l> :TmuxNavigateRight<cr>
