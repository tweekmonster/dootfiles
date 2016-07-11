let b:delimitMate_nesting_quotes = ['"', "'"]

setlocal completeopt-=preview
setlocal textwidth=79
setlocal shiftwidth=4
setlocal tabstop=4
setlocal softtabstop=4
setlocal formatoptions-=t

function! s:set_pdb() abort
  if getline('.') !~# '^\s*import i\?pdb'
    normal! oimport pdb; pdb.set_trace()
  else
    delete _
  endif
endfunction

nnoremap <buffer> <localleader>d :<c-u>call <sid>set_pdb()<cr>
nnoremap <buffer> <localleader>D :<c-u>g/^\s*import i\?pdb/delete _<cr>


BracelessEnable +indent +fold-inner +highlight-cc2

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
