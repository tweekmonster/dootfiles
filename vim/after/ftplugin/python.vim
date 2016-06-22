let b:delimitMate_nesting_quotes = ['"', "'"]

setlocal completeopt-=preview
setlocal textwidth=79
setlocal shiftwidth=4
setlocal tabstop=4
setlocal softtabstop=4

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
