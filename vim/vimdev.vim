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
function! vimdev#scan() abort
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
