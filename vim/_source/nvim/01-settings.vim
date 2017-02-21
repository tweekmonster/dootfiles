let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 2
let $NVIM_TUI_ENABLE_TRUE_COLOR = 1

set termguicolors

execute 'set viminfo+=n'.g:_vimrc_base.'/nviminfo'

if exists('&messagebuf')
  set messagebuf
endif

if exists('&inccommand')
  set inccommand=split
endif
