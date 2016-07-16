if &l:buftype == 'help' || expand('%') =~# '^'.$VIMRUNTIME
      \ || expand('%') =~# '^'.g:_vimrc_plugins
  setlocal buftype=help
  setlocal nolist
  setlocal norelativenumber
  setlocal nonumber
  setlocal nomodifiable
  setlocal readonly
  setlocal noswapfile
  setlocal nobuflisted
  exec 'sign unplace * file='.expand('%')

  " Jump over helptag concealed characters
  function! s:adjust_cursor(...) abort
    let pos = getpos('.')[1:2]
    if mode() ==? 'v' || !exists('b:prev_pos')
      let b:prev_pos = pos
      return
    endif

    let line = getline(pos[0])
    let b1 = line2byte(pos[0]) + pos[1]
    let b2 = line2byte(b:prev_pos[0]) + b:prev_pos[1]
    let b:prev_pos = getpos('.')[1:2]
    let delta = b1 - b2
    if b1 == b2
      return
    endif
    let conceal = synconcealed(pos[0], pos[1])

    if &conceallevel && conceal[0]
      if !a:0 && abs(delta) == 1
        if delta < 0
          normal! h
        elseif delta > 0
          normal! l
        endif
      else
        if b1 < b2
          let c = match(line, '\S\zs\s*\%'.pos[1].'c')
          if c != -1
            call cursor(pos[0], c)
          else
            normal! ge
          endif
        elseif b1 > b2
          let c = matchend(line, '\%>'.pos[1].'c\s*\S')
          if c != -1
            call cursor(pos[0], c)
          else
            normal! w
          endif
        endif
        call s:adjust_cursor(1)
      endif
    endif
  endfunction

  augroup vimrc_help
    autocmd! * <buffer>
    autocmd CursorMoved <buffer> call s:adjust_cursor()
  augroup END
endif
