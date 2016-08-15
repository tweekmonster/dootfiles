let b:delimitMate_nesting_quotes = ['"', "'"]

setlocal completeopt-=preview
setlocal textwidth=79
setlocal shiftwidth=4
setlocal tabstop=4
setlocal softtabstop=4
setlocal formatoptions-=t

function! s:set_pdb() abort
  if getline('.') !~# '^\s*import i\?pdb'
    if !exists('s:pdb_module')
      call system('python -c "import ipdb"')
      if !v:shell_error
        let s:pdb_module = 'ipdb'
      else
        let s:pdb_module = 'pdb'
      endif
    endif

    execute 'normal! oimport '.s:pdb_module.'; '.s:pdb_module.'.set_trace()'
  else
    delete _
  endif
endfunction


function! s:remove_all_pdb() abort
  g/^\s*import i\?pdb/delete _
  call histdel('search', -1)
  let @/ = histget('search', -1)
endfunction

nnoremap <buffer> <localleader>d :<c-u>call <sid>set_pdb()<cr>
nnoremap <buffer> <localleader>D :<c-u>call <sid>remove_all_pdb()<cr>


if &l:diff
  finish
endif

BracelessEnable +indent +fold +highlight-cc2

if exists(':ImpSort')
  let b:_import_seen = []

  if !exists('#impsort#InsertLeave#<buffer>')
    if impsort#is_sorted()
      ImpSortAuto!
    elseif !exists('SessionLoad')
      redraw
      echohl WarningMsg
      echo 'ImpSortAuto not enabled because imports are not sorted'
      echohl None
    endif
  endif
endif
