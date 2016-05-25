let delimitMate_expand_cr = 2
let delimitMate_jump_expansion = 1
let delimitMate_matchpairs = "(:),[:],{:}"

augroup vimrc_delimitMate
  autocmd!
  autocmd FileType python let b:delimitMate_nesting_quotes = ['"', "'"]
augroup END
