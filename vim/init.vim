if has('vim_starting')
  scriptencoding utf-8
  set encoding=utf-8
endif

let g:_vimrc_base = expand('<sfile>:p:h')
let g:_vimrc_plugins = g:_vimrc_base.'/plugins'
let g:_vimrc_init = isdirectory(g:_vimrc_plugins)
let g:_vimrc_dev_dir = expand('~/dev/vim')

if !exists('g:_vimrc_sources')
  let g:_vimrc_sources = {}
endif

" Source all scripts in a directory
" Prefixes 01 to 03 are always loaded.  Prefixes 04 and above are plugin
" specific.  If the designated plugin directory does not exist, do not load
" plugin specific configs to avoid startup errors on first run.
function! s:source(dir) abort
  for filename in sort(glob(g:_vimrc_base.'/_source/'.a:dir.'/*.vim', 0, 1))
    if !g:_vimrc_init && str2nr(fnamemodify(filename, ':t')[:1]) > 3
      continue
    endif

    let mtime = getftime(filename)
    if !has_key(g:_vimrc_sources, filename) || g:_vimrc_sources[filename] < mtime
      let g:_vimrc_sources[filename] = mtime
      execute 'source '.filename
    endif
  endfor
endfunction

call s:source('all')

if has('nvim')
  call s:source('nvim')
else
  call s:source('vim')
endif

let s:vimrc_local = expand('$HOME/.vimrc_local')
if filereadable(s:vimrc_local)
  exec 'source '.s:vimrc_local
endif

if !g:_vimrc_init
  autocmd! VimEnter * echohl WarningMsg |
        \ echomsg '!!! Plugins are not installed !!!' |
        \ echohl None
endif
