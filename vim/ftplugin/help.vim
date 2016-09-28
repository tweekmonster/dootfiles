if &l:buftype == 'help' || expand('%') =~# '^'.$VIMRUNTIME
      \ || expand('%') =~# '^'.g:_vimrc_plugins

  let b:helpful = 1

  setlocal buftype=help
  setlocal nolist
  setlocal norelativenumber
  setlocal nonumber
  setlocal nomodifiable
  setlocal readonly
  setlocal noswapfile
  setlocal nobuflisted
  exec 'sign unplace * file='.expand('%')
endif
