" Utilities for swapping out plugin directories in development mode
let s:dev_config = g:_vimrc_base.'/.plugin_dev'
let s:plugdirs = ['after', 'autoload', 'colors', 'ftplugin', 'indent', 'keymap', 'plugin', 'syntax']


function! s:is_plugin(dir) abort
  for p in s:plugdirs
    if filewritable(a:dir.'/'.p) == 2
      return 1
    endif
  endfor
  return 0
endfunction


function! s:sort_date(a, b) abort
  if a:a[-1] < a:b[-1]
    return -1
  elseif a:a[-1] > a:b[-1]
    return 1
  endif
  return 0
endfunction


function! s:dirdate(dir) abort
  let newest = 0
  for p in s:plugdirs
    let d_newest = max(map(split(glob(a:dir.'/'.p.'/**'), "\n"), 'getftime(v:val)'))
    if d_newest > newest
      let newest = d_newest
    endif
  endfor
  return newest
endfunction


function! s:dev_plugins(...) abort
  if a:0
    let plugs = []
    for dir in split(glob(g:_vimrc_dev_dir.'/*'), "\n")
      if s:is_plugin(dir)
        call add(plugs, [dir, s:dirdate(dir)])
      endif
    endfor
    return reverse(map(sort(plugs, 's:sort_date'), 'fnamemodify(v:val[0], ":t")'))
  endif

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
    let devdir = g:_vimrc_dev_dir.'/'.name
    if !isdirectory(devdir)
      continue
    endif

    if has_key(g:plugs, name)
      call remove(g:plugs[name], 'uri')
      let g:plugs[name]['dir'] = g:_vimrc_dev_dir.'/'.name
    else
      if name =~# '\.nvim$' && !has('nvim')
        continue
      endif
      execute 'Plug '''.devdir.''''
    endif
  endfor
endfunction


function! s:dev_add_completion(A, L, P) abort
  let plugs = []
  let plugins = s:dev_plugins()
  let all_dev_plugins = s:dev_plugins(1)

  for p in all_dev_plugins
    if index(plugins, p) == -1
      echomsg p
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
  let plugin = a:plugin
  let plugins = s:dev_plugins()

  if empty(a:plugin)
    let plugins_sel = []
    for p in plugins
      call add(plugins_sel, printf('%2d. %s', len(plugins_sel) + 1, p))
    endfor
    redraw
    let i = inputlist(plugins_sel) - 1
    if i == -1 || i >= len(plugins)
      return
    endif
    let plugin = plugins[i]
  else
    let i = index(plugins, a:plugin)
    if i == -1
      echohl ErrorMsg
      echomsg plugin.' is not in dev mode'
      echohl None
      return
    endif
  endif

  call remove(plugins, i)
  call writefile(plugins, s:dev_config)

  redraw
  echohl WarningMsg
  echomsg plugin.' removed from dev list.  Restart to take effect.'
  echohl None
endfunction


command! -nargs=1 -complete=custom,<sid>dev_add_completion PlugDevAdd
      \ call <sid>dev_add('<args>')
command! -nargs=? -complete=custom,<sid>dev_remove_completion PlugDevRemove
      \ call <sid>dev_remove('<args>')
