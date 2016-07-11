nnoremap <silent><buffer> q :<c-u>quit<cr>
nnoremap <silent><buffer> ,p :<c-u>let &l:conceallevel = &l:conceallevel ? 0 : 2<cr>
if &l:conceallevel == 0
  setlocal conceallevel=2
endif
