setlocal foldmethod=manual
nnoremap <buffer> zc zfi{
nnoremap <buffer> zo zd

setlocal expandtab shiftwidth=2 softtabstop=2 textwidth=80
setlocal modelines=0 cinoptions=0(
setlocal comments=:///,://

let s:source_ext = ['.c', '.cpp', '.cc', '.cxx', '.m', '.mm']
let s:header_ext = ['.h', '.hh', '.hpp']

function! s:swap_companion(...) abort
  let file = expand('%')
  let ext = fnamemodify(file, ':e')
  let root = fnamemodify(file, ':r')

  let search_ext = ext =~? '^h' ? s:source_ext : s:header_ext
  for e in search_ext
    echo root.e
    if filereadable(root.e)
      return ':keepalt '.(a:0 ? 'vs' : 'e').' '.root.e."\<cr>"
      break
    endif
  endfor
  return "\<esc>"
endfunction

nnoremap <buffer><expr><silent> <leader>% <sid>swap_companion()
nnoremap <buffer><expr><silent> <localleader>% <sid>swap_companion(1)
