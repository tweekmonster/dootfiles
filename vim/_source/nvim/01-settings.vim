let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
execute 'set viminfo+=n'.g:_vimrc_base.'/nviminfo'

augroup vimrc_nvim
  autocmd!
  autocmd TermOpen * setlocal nospell
augroup END
