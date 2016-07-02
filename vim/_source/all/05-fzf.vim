if executable('pt')
  " Filter items through ag to respect gitignore
  let $FZF_DEFAULT_COMMAND = 'pt -l -g ""'
endif

let g:fzf_filemru_bufwrite = 1
let g:fzf_layout = {'window': 'aboveleft 10new'}
nnoremap <silent> <c-p> :ProjectMru --tiebreak=index --inline-info<cr>
nnoremap <leader>e :BTags<cr>
nnoremap <leader>E :BLines<cr>
nnoremap <leader>L :Lines<cr>
nnoremap <leader>B :Buffers<cr>
