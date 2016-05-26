if exists('g:_did_vimrc_plugins')
  finish
endif

let g:_did_vimrc_plugins = 1

" BEGIN plugin dev
" Utilities for swapping out plugin directories in development mode
let s:dev_config = g:_vimrc_base.'/.plugin_dev'


function! s:dev_plugins() abort
  if filereadable(s:dev_config)
    return readfile(s:dev_config)
  endif
  return []
endfunction


" Check s:dev_plugins() for matching Plug entries.  If found, remove the URI and
" change the directory.  Since this only rewrites entries, the order defined
" below will be preserved.
"
" This should be called just before plug#end().
function! s:dev_scan() abort
  for name in s:dev_plugins()
    if has_key(g:plugs, name) && isdirectory(g:_vimrc_dev_dir.'/'.name)
      call remove(g:plugs[name], 'uri')
      let g:plugs[name]['dir'] = g:_vimrc_dev_dir.'/'.name
    endif
  endfor
endfunction


function! s:dev_add_completion(A, L, P) abort
  let plugs = []
  let plugins = s:dev_plugins()
  for p in g:plugs_order
    if index(plugins, p) == -1
      call add(plugs, p)
    endif
  endfor
  return join(plugs, "\n")
endfunction


function! s:dev_remove_completion(A, L, P) abort
  return join(s:dev_plugins(), "\n")
endfunction


function! s:dev_add(plugin) abort
  let plugins = s:dev_plugins()
  if index(plugins, a:plugin) != -1
    echomsg a:plugin.' is already in dev mode'
    return
  endif

  call add(plugins, a:plugin)
  call writefile(plugins, s:dev_config)

  echohl WarningMsg
  echomsg a:plugin.' added to dev list.  Restart for dev mode to take effect.'

  if !isdirectory(g:_vimrc_dev_dir.'/'.a:plugin)
    echomsg a:plugin.' is not in '.g:_vimrc_dev_dir
  endif

  echohl None
endfunction


function! s:dev_remove(plugin) abort
  let plugins = s:dev_plugins()
  let i = index(plugins, a:plugin)
  if i == -1
    echohl ErrorMsg
    echomsg a:plugin.' is not in dev mode'
    echohl None
    return
  endif

  call remove(plugins, i)
  call writefile(plugins, s:dev_config)

  echohl WarningMsg
  echomsg a:plugin.' removed from dev list.  Restart to take effect.'
  echohl None
endfunction


command! -nargs=1 -complete=custom,<sid>dev_add_completion PlugDevAdd
      \ call <sid>dev_add('<args>')
command! -nargs=1 -complete=custom,<sid>dev_remove_completion PlugDevRemove
      \ call <sid>dev_remove('<args>')

" END plugin dev


call plug#begin(g:_vimrc_plugins)

" Load bundled first
function! s:load_bundles() abort
  for dir in glob(g:_vimrc_base.'/bundled/*', 0, 1)
    if !isdirectory(dir)
      continue
    endif
    execute 'Plug '''.dir.''''
  endfor
endfunction

call s:load_bundles()

" Certain plugin developers are prolific enough to group their plugins
" together.  Some may require a specific order and grouping them makes it
" easier to deal with.

" Shougo
Plug 'Shougo/vimproc.vim', {'do': 'make'}
Plug 'Shougo/unite.vim'
Plug 'Shougo/vimfiler.vim'
Plug 'Shougo/deoplete.nvim'
Plug 'Shougo/echodoc.vim'
Plug 'Shougo/neco-vim'

" Shougo - Deoplete
Plug 'carlitux/deoplete-ternjs'
Plug 'zchee/deoplete-jedi'

" junegunn
Plug 'junegunn/fzf', {'do': './install --bin'}
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vader.vim'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/vim-peekaboo'

" tpope
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-scriptease'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-scriptease'

" My stuff
Plug 'tweekmonster/fzf-filemru'
Plug 'tweekmonster/braceless.vim'
Plug 'tweekmonster/sshclip', {'do': './bin/sshclip-client --impersonate sshclip'}

" Theming
Plug 'bling/vim-airline'
Plug 'ryanoasis/vim-devicons'

" Project Related
Plug 'benekastah/neomake'
Plug 'gregsexton/gitv'
Plug 'airblade/vim-gitgutter'
Plug 'airblade/vim-rooter'
Plug 'editorconfig/editorconfig-vim'

" Snippets
Plug 'mattn/emmet-vim'
if v:version > 703
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'
endif

" Utilities
Plug 'FooSoft/vim-argwrap'
Plug 'Lokaltog/vim-easymotion'
Plug 'Raimondi/delimitMate'
Plug 'chrisbra/NrrwRgn'
Plug 'christoomey/vim-tmux-navigator'
Plug 'editorconfig/editorconfig-vim'
Plug 'edsono/vim-matchit'
Plug 'kana/vim-textobj-line'
Plug 'kana/vim-textobj-user'
Plug 'michaeljsmith/vim-indent-object'
Plug 'tomtom/tcomment_vim'
Plug 'vim-scripts/BufOnly.vim'
Plug 'wellle/targets.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'vim-scripts/BufOnly.vim'

" Web Development
Plug 'fatih/vim-nginx'
Plug 'othree/xml.vim'
Plug 'othree/html5.vim'
Plug 'othree/yajs.vim'
Plug 'nono/jquery.vim'
Plug 'pangloss/vim-javascript'
Plug 'kchmck/vim-coffee-script'
Plug 'groenewege/vim-less'
Plug 'csscomb/vim-csscomb'
Plug 'posva/vim-vue'

" Misc File Types
Plug 'davidhalter/jedi-vim'
Plug 'hdima/python-syntax'
Plug 'tmux-plugins/vim-tmux'
Plug 'fatih/vim-go'
Plug 'elzr/vim-json'
Plug 'cespare/vim-toml'
Plug 'plasticboy/vim-markdown'
Plug 'mzlogin/vim-markdown-toc'
Plug 'ekalinin/Dockerfile.vim'

" Scan for development replacements before plug#end()
call s:dev_scan()

call plug#end()
