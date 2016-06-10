let g:rooter_silent_chdir = 1
let g:rooter_patterns = ['.vimroot', '.git/']

augroup vimrc_rooter
  autocmd VimEnter * Rooter
augroup END
