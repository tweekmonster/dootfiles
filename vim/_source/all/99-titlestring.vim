function! DootfilesGetTitleString() abort
  try
    return fnamemodify(fugitive#repo().tree(), ':t')
  catch
    return fnamemodify(getcwd(), ':t')
  endtry
endfunction

set title
set titlestring=[%{has('nvim')?'nvim':'vim'}]\ %{DootfilesGetTitleString()}
