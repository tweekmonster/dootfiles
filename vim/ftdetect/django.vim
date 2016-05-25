" Django-related file detection
" Maintainer:       Tommy Allen <tommy@esdf.io>
" Latest Reivison:  Wed May 25 11:08:49 EDT 2016

let s:cpo_save = &cpo
set cpo&vim

let s:seen = {}
let s:django_app_modules = [
      \ 'admin',
      \ 'apps',
      \ 'managers',
      \ 'migrations',
      \ 'models',
      \ 'templatetags',
      \ 'tests',
      \ 'urls',
      \ 'views',
      \ ]

let s:django_app_dirs = [
      \ 'static',
      \ 'templates',
      \ ]


" Test a file name to see if it's a python module.
function! s:has_module(dirname, module)
  return filereadable(a:dirname.'/'.a:module.'.py')
        \ || filereadable(a:dirname.'/'.a:module.'/__init__.py')
endfunction


" Test a directory for a management script>
function! s:is_django_project(dirname)
  if filereadable(a:dirname.'/manage.py')
    let s:management_script = a:dirname.'/manage.py'
    return 1
  endif
  return 0
endfunction


" Test a directory to see if it looks like a Django app.
function! s:is_django_app(dirname)
  let min_matches = 2
  let dirname = a:dirname

  if filereadable(dirname.'/__init__.py')
    " Apps are modules
    let match_count = 0
    for name in s:django_app_dirs
      if isdirectory(dirname.'/'.name)
        let match_count += 1
        if match_count >= min_matches
          return 1
        endif
      endif
    endfor

    for name in s:django_app_modules
      if s:has_module(dirname, name)
        let match_count += 1
        if match_count >= match_count
          return 1
        endif
      endif
    endfor
  endif

  return 0
endfunction


" Scan parents for a match
function! s:scan(filename, func) abort
  if empty(a:filename)
    return 0
  endif

  let cwd = getcwd()
  let dirname = fnamemodify(a:filename, ':p:h')
  let last_dir = ''
  while dirname != last_dir && dirname !~ '^\/*$'
    let last_dir = dirname

    if has_key(s:seen, dirname)
      if s:seen[dirname]
        return 1
      else
        let dirname = fnamemodify(dirname, ':h')
        continue
      endif
    endif

    if call(a:func, [dirname])
      let s:seen[dirname] = 1
      return 1
    endif

    let s:seen[dirname] = 0
    if dirname == cwd
      break
    endif
    let dirname = fnamemodify(dirname, ':h')
  endwhile

  return 0
endfunction


" Detect Django related files
function! s:detect(filename) abort
  let ext = fnamemodify(a:filename, ':e')

  if s:scan(a:filename, 's:is_django_project') || s:scan(a:filename, 's:is_django_app')
    let b:is_django = 1
    if ext =~? 'html\?'
      setlocal filetype=htmldjango
    endif
  endif
endfunction


autocmd BufRead,BufNewFile *.py,*.htm,*.html call <sid>detect(expand('<afile>'))

let &cpo = s:cpo_save
unlet s:cpo_save
