" General annoying shit

highlight default link WrongTab Error

function! s:highlight_wrong_tabs() abort
  if &l:filetype =~# 'help\|man'
    return
  endif

  silent! syntax clear WrongTab
  let pat = '^ \+'
  if &l:expandtab
    let pat = '^\t\+'
  endif

  execute 'syntax match WrongTab #'.pat.'# containedin=ALL'
endfunction

augroup vimrc_annoying
  autocmd!
  autocmd VimEnter * set visualbell t_vb=
  autocmd GUIEnter * set visualbell t_vb=
  autocmd Syntax * call s:highlight_wrong_tabs()

  " This makes it so Python documentation buffers go away
  autocmd BufWinEnter '__doc__' setlocal bufhidden=delete
  " autocmd BufWinEnter,SessionLoadPost * silent! %foldopen!
  autocmd FileChangedRO * setlocal noreadonly
augroup END


" sudo write using ✨magic✨
cnoremap <silent><expr> <cr> filereadable(bufname('%')) && !filewritable(bufname('%')) && getcmdtype() == ':' && getcmdline() ==# 'w'
      \ ? "\<bs>:call execute(\"".(has('mac') ? "w !osascript -e 'do shell script \\\"cat 0<&3 > %\\\" with administrator privileges' 3<&0" : "w !sudo dd of=% 2>/dev/null")."\")\<cr>:e!\<cr>"
      \ : "\<cr>"

" Some commands should just do what I want, even in visual mode.
cnoremap <expr> w getcmdtype() == ':' && getcmdline() ==# "'<,'>" ? "\<c-u>w" : 'w'
cnoremap <expr> q getcmdtype() == ':' && getcmdline() ==# "'<,'>" ? "\<c-u>q" : 'q'
