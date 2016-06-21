set colorcolumn=80
set completeopt+=menuone
set completeopt-=preview
try
  set completeopt+=noinsert
catch
endtry
set concealcursor=nc
set cursorline
set hidden
set hlsearch
set incsearch
set laststatus=2
set lazyredraw
set modelines=5
set mouse=a
set mousemodel=extend
set nofoldenable
set noshowmode
set nowrap
set number
set showcmd
set splitbelow
set splitright
set wildmenu

try
  colorscheme base16_custom
catch
endtry

if !has('nvim')
  set ttyfast
  if &term =~ '^screen'
    set ttymouse=xterm2
  endif
endif

" Spacing and Tabs {{{1
set autoindent
set backspace=2
set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2

" Backup and Undo
set backup
let s:backup_dir = expand('~/.cache/vim_tmp')
if !isdirectory(s:backup_dir)
    call mkdir(s:backup_dir, 'p', 0700)
endif
let s:backup_dir .= '//'  " Store backups in a full path
exec 'set backupdir=' . s:backup_dir . ' directory=' . s:backup_dir
set backupskip=/tmp/*,/private/tmp/*
set writebackup
set history=10000
set viminfo='100,<50

set undofile
let s:undo_dir = expand('~/.cache/vim_undo')
if !isdirectory(s:undo_dir)
    call mkdir(s:undo_dir, 'p', 0700)
endif
exec 'set undodir=' . s:undo_dir
