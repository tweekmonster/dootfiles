let g:rooter_patterns = ['.vimroot', '.git/']

augroup vimrc_rooter
  autocmd VimEnter * Rooter
augroup END
