let g:vimwiki_list = [{'path': '~/.local/share/vimwiki'}]

function! s:close_wikis() abort
  for i in range(1, bufnr('$'))
    if bufexists(i) && getbufvar(i, '&filetype') == 'vimwiki' && winbufnr(i) == -1
      execute i 'bdelete'
    endif
  endfor
endfunction

autocmd TabLeave * call s:close_wikis()
