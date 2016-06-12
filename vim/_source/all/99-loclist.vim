function! s:pos2byte(pos) abort
  return line2byte(a:pos[0]) + a:pos[1]
endfunction


function! s:get_next(dir) abort
  let pos = getpos('.')[1:2]
  let pb = s:pos2byte(pos)
  let locations = getloclist(0)
  let ll_len = len(locations)

  if ll_len
    if ll_len == 1
      return [locations[0].lnum, locations[0].col]
    endif

    let l_first = locations[0]
    let l_last = locations[-1]

    if a:dir == -1
      call reverse(locations)
    endif

    for info in locations
      let loc = [info.lnum, info.col]
      let loc_b = s:pos2byte(loc)

      if (a:dir == -1 && pb > loc_b) || (a:dir == 1 && pb < loc_b)
        return loc
      endif
    endfor

    let loc = [l_first.lnum, l_first.col]
    let loc_b = s:pos2byte(loc)
    if pb <= loc_b
      if a:dir == -1
        return [l_last.lnum, l_last.col]
      else
        return loc
      endif
    endif

    let loc = [l_last.lnum, l_last.col]
    let loc_b = s:pos2byte(loc)
    if pb >= loc_b
      if a:dir == -1
        return loc
      else
        return [l_first.lnum, l_first.col]
      endif
    endif
  endif

  return pos
endfunction


function! s:ll_move(dir) abort
  let pos = s:get_next(a:dir)
  execute 'normal! '.pos[0].'G'.pos[1].'|'
endfunction


nnoremap <silent><up> :<c-u>call <sid>ll_move(-1)<cr>
nnoremap <silent><down> :<c-u>call <sid>ll_move(1)<cr>
