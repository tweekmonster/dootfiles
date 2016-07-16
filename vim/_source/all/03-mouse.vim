" Adjusts the click position of the mouse on lines with concealed characters
function! s:cursor_adjust() abort
  if !&conceallevel
    return
  endif

  let cmax = col('$')
  let cpos = col('.')
  let level = &conceallevel
  let lnum = line('.')
  let lastid = 0
  let i = 0

  while i < cpos && cpos < cmax
    let i += 1
    let conceal = synconcealed(lnum, i)

    if conceal[0]
      let consecutive = conceal[2] == lastid
      if level == 1
        let cpos += !consecutive ? 0 : 1
      elseif level == 2
        let cpos += conceal[1] == '' ? 1 :
              \ !consecutive ? 0 : 1
      elseif level == 3
        let cpos += 1
      endif
    endif

    let lastid = conceal[2]
  endwhile

  if cpos != col('.')
    call cursor(lnum, cpos)
  endif
endfunction

nnoremap <silent> <LeftMouse> <LeftMouse>:<c-u>call <sid>cursor_adjust()<cr>
