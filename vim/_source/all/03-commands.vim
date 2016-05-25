function! s:forget_undo()
  let old_undolevels = &undolevels
  set undolevels=-1
  exe "normal a \<BS>\<Esc>"
  let &undolevels = old_undolevels
  unlet old_undolevels
endfunction

command -nargs=0 ClearUndo call <SID>forget_undo()
