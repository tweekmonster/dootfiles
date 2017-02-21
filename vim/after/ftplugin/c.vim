if &foldmethod == 'syntax'
  setlocal foldmethod=manual
  nnoremap <buffer> zc zfi{
  nnoremap <buffer> zo zd
endif

setlocal expandtab shiftwidth=2 softtabstop=2 textwidth=80
setlocal cinoptions=0(,W4
setlocal comments=:///,://

let s:source_ext = ['.c', '.cpp', '.cc', '.cxx', '.m', '.mm']
let s:header_ext = ['.h', '.hh', '.hpp']

function! s:swap_companion(...) abort
  let file = expand('%')
  let ext = fnamemodify(file, ':e')
  let root = fnamemodify(file, ':r')

  let search_ext = ext =~? '^h' ? s:source_ext : s:header_ext
  for e in search_ext
    if filereadable(root.e)
      return ':keepalt '.(a:0 ? 'vs' : 'e').' '.root.e."\<cr>"
      break
    endif
  endfor
  return "\<esc>"
endfunction

nnoremap <buffer><expr><silent> <leader>% <sid>swap_companion()
nnoremap <buffer><expr><silent> <localleader>% <sid>swap_companion(1)

function! s:pragma_jump() abort
  let view = winsaveview()

  call cursor(1, 1)
  let lines = []
  let previews = []
  let next_line = search('^#pragma', 'W')

  while next_line != 0
    call add(lines, next_line)
    call add(previews, printf('%2d. %s', len(lines), getline(next_line)))

    let l = search('^#pragma', 'W')
    if l == next_line
      break
    endif

    let next_line = l
  endwhile

  call winrestview(view)

  let choice = inputlist(previews)
  if choice > 0 && choice <= len(lines)
    execute 'normal! '.lines[choice - 1].'G'
  endif
endfunction

command! -buffer Pragma call s:pragma_jump()
