function! s:runtime_glob(globpat, ...) abort
  let list = map(globpath(&runtimepath, a:globpat, 0, 1), '{"filename": v:val, "nr": 1}')
  if empty(list)
    echomsg 'No match for:' a:globpat
    return
  endif

  call setqflist(list, a:0 ? a:1 : 'r')
  copen
endfunction


function! s:runtime_grep(globpat, ...) abort
  if !a:0
    echohl ErrorMsg
    echomsg 'A pattern is required'
    echohl None
    return
  endif

  let pattern = join(a:000)
  call setqflist([], 'r')

  for path in globpath(&runtimepath, a:globpat, 0, 1)
    if filereadable(path)
      try
        execute 'vimgrepadd /'.pattern.'/gj' path
      catch
      endtry
    endif
  endfor

  if !empty(getqflist())
    copen
  endif
endfunction


function! s:filetype_scripts(filetype) abort
  call s:runtime_glob('ftplugin/'.a:filetype.'.vim')
  call s:runtime_glob('ftplugin/'.a:filetype.'/*.vim', 'a')
  call s:runtime_glob('syntax/'.a:filetype.'.vim', 'a')
  call s:runtime_glob('syntax/'.a:filetype.'/*.vim', 'a')
endfunction


command! -nargs=1 RtpGlob call s:runtime_glob('<args>')
command! -nargs=+ RtpGrep call s:runtime_grep(<f-args>)
command! -nargs=1 -complete=filetype FiletypeScripts call s:filetype_scripts('<args>')
