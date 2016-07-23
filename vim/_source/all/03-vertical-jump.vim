function! s:getline(lnum, col) abort
  let line = getline(a:lnum)
  let i = 0
  let c = 0
  let maxc = min([strlen(line), a:col])
  let out = ''
  while c < maxc && i < maxc
    let char = line[i]
    let out .= char
    let i += 1
    let c += strdisplaywidth(char)
  endwhile
  return out
endfunction

" Jump to next non-blank line
function! s:vert_jump(dir, by_col, visual) abort
  if a:visual
    normal! gv
  endif

  let start_line = line('.')

  let line = start_line
  let c = v:count ? v:count : 1
  if a:dir == -1
    let func = 'prevnonblank'
  else
    let func = 'nextnonblank'
  endif

  if !a:by_col
    while c && line
      let line = call(func, [line + a:dir])
      let c -= 1
    endwhile
  else
    let l = line
    let lc = col('.')
    let vc = virtcol('.')

    while c && l
      let l = call(func, [line + a:dir])
      while l && (s:getline(l, lc) =~# '^\s*$' || strdisplaywidth(getline(l)) < vc)
        let l = call(func, [l + a:dir])
      endwhile
      let line = l
      let c -= 1
    endwhile
  endif

  if line != 0 && line != start_line
    let dist = start_line - line
    let key = 'k'
    if dist < 0
      let key = 'j'
    endif
    execute 'normal! m'''.abs(dist).key
  endif
endfunction


" Navigate lines as shown on the screen
nnoremap j gj
nnoremap k gk
xnoremap j gj
xnoremap k gk

" Vertical jump to non-blank lines.  gJ and gK will jump to non-blank lines
" that are long enough to use the current column position.
nnoremap <silent> gk :<c-u>call <sid>vert_jump(-1, 0, 0)<cr>
nnoremap <silent> gj :<c-u>call <sid>vert_jump(1, 0, 0)<cr>
nnoremap <silent> gK :<c-u>call <sid>vert_jump(-1, 1, 0)<cr>
nnoremap <silent> gJ :<c-u>call <sid>vert_jump(1, 1, 0)<cr>

xnoremap <silent> gk :<c-u>call <sid>vert_jump(-1, 0, 1)<cr>
xnoremap <silent> gj :<c-u>call <sid>vert_jump(1, 0, 1)<cr>
xnoremap <silent> gK :<c-u>call <sid>vert_jump(-1, 1, 1)<cr>
xnoremap <silent> gJ :<c-u>call <sid>vert_jump(1, 1, 1)<cr>
