" Used this in an answer at: http://vi.stackexchange.com/q/8707/5229
"
" There is a bug in matchit.vim that's causing the top of the current window
" to be added to the jumplist.  A fixed copy of it has been included in the
" dootfiles under vim/bundled/matchit.  It also has a modification
" (b:match_nomark) to work specificially with this script to help with keeping
" the jumplist unmodified.
let s:match_id = 6282448


function! s:get_match_lines(line) abort
  let lines = []
  let guard = 0
  let b:match_nomark = 1

  " Loop until `%` returns the original line number
  while guard < 50
    lockmarks normal %
    if line('.') == a:line || index(lines, line('.')) != -1
      " Note that the current line number is never added to the `lines`
      " list.
      break
    endif
    let guard += 1
    call add(lines, line('.'))
  endwhile

  unlet! b:match_nomark
  return lines
endfunction

function! s:hl_matching_lines() abort
  " `b:hl_last_line` prevents running the script again while the cursor is
  " moved on the same line.  Otherwise, the cursor won't move if the current
  " line has matching pairs of something.
  if exists('b:hl_last_line') && b:hl_last_line == line('.')
    return
  endif

  let b:hl_last_line = line('.')

  " Save the window's state.
  let view = winsaveview()

  " Delete a previous match highlight.  `s:match_id` is used for the match ID.
  " It can be anything as long as it's unique.
  silent! call matchdelete(s:match_id)

  " Try to get matching lines from the current cursor position.
  let lines = s:get_match_lines(view.lnum)

  if empty(lines)
    " It's possible that the line has another matching line, but can't be
    " matched at the current column.  Move the cursor to column 1 to try
    " one more time.
    call cursor(view.lnum, 1)
    let lines = s:get_match_lines(view.lnum)
  endif

  if len(lines)
    " Since the current line is not in the `lines` list, only the other
    " lines are highlighted.  If you want to highlight the current line as
    " well:
    " call add(lines, view.lnum)
    if exists('*matchaddpos')
      " If matchaddpos() is availble, use it to highlight the lines since it's
      " faster than using a pattern in matchadd().
      call matchaddpos('MatchLine', lines, 0, s:match_id)
    else
      " Highlight the matching lines using the \%l atom.  The `MatchLine`
      " highlight group is used.
      call matchadd('MatchLine', join(map(lines, '''\%''.v:val.''l'''), '\|'), 0, s:match_id)
    endif
  endif

  " Restore the window's state.
  call winrestview(view)
endfunction

function! s:hl_matching_lines_clear() abort
  silent! call matchdelete(s:match_id)
  unlet! b:hl_last_line
endfunction


function! s:hl_setup() abort
  if get(b:, 'match_cursormove', get(g:, 'match_cursormove', 0)) && !exists('#matching_lines#CursorMoved#<buffer>')
    augroup matching_lines
      autocmd! * <buffer>
      autocmd CursorMoved <buffer> silent! call s:hl_matching_lines()
    augroup END
  endif
endfunction


" The highlight group that's used for highlighting matched lines.  By
" default, it will be the same as the `MatchParen` group.
highlight default link MatchLine MatchParen

augroup matching_lines
  autocmd!
  autocmd! BufWinEnter * call s:hl_setup()
  " Remove the highlight while in insert mode.
  autocmd InsertEnter * call s:hl_matching_lines_clear()
  " Remove the highlight after TextChanged.
  autocmd TextChanged,TextChangedI * call s:hl_matching_lines_clear()
augroup END

nnoremap <silent> <leader>l :<c-u>call <sid>hl_matching_lines()<cr>
