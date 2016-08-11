function! DootfilesGetTitleString() abort
  if filereadable(expand('%'))
    try
      return fnamemodify(fugitive#repo().tree(), ':p:s?/$??:t')
    catch
    endtry
  endif

  return fnamemodify(getcwd(), ':t')
endfunction

set title
set titlestring=%{DootfilesGetTitleString()}
