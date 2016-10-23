let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1
let $NVIM_TUI_ENABLE_TRUE_COLOR = 1

set termguicolors

execute 'set viminfo+=n'.g:_vimrc_base.'/nviminfo'

if has('msgbuf')
  set messagebuf
endif
