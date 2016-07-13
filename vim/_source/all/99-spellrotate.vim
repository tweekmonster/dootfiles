" Used as an answer at: http://vi.stackexchange.com/q/8692/5229

function! s:spell_rotate(dir, visual) abort
  if a:visual
    " Restore selection.  This line is seen throughout the function if the
    " selection is cleared right before a potential return.
    normal! gv
    if getline("'<") != getline("'>")
      echo 'Spell Rotate: can''t give suggestions for multiple lines'
      return
    endif
  endif

  if !&spell
    echo 'Spell Rotate: spell not enabled.'
    return
  endif

  " Keep the view to restore after a possible jump using the change marks.
  let view = winsaveview()
  let on_spell_word = 0

  if exists('b:_spell')
    let bounds = b:_spell.bounds
    " Confirm that the cursor is between the bounds being tracked.
    let on_spell_word = bounds[0][0] == bounds[1][0]
          \ && view.lnum == bounds[0][0]
          \ && view.col >= bounds[0][1]
          \ && view.col <= bounds[1][1]
  endif

  " Make sure the correct register is used
  let register = &clipboard == 'unnamed'
        \ ? '*' : &clipboard == 'unnamedplus'
        \ ? '+' : '"'

  " Store the text in the unnamed register.  Note that yanking will clear
  " the visual selection.
  if on_spell_word
    if a:visual
      keepjumps normal! y
    else
      keepjumps normal! `[v`]y
    endif
    call winrestview(view)
  elseif a:visual
    keepjumps normal! y
  else
    keepjumps normal! viwy
  endif

  let cword = getreg(register)

  if !on_spell_word || b:_spell.alts[b:_spell.index] != cword
    " Start a new list of suggestions.  The word being replaced will
    " always be at index 0.
    let spell_list = [cword] + spellsuggest(cword)
    let b:_spell = {
          \ 'index': 0,
          \ 'bounds': [[0, 0], [0, 0]],
          \ 'cword': cword,
          \ 'alts': spell_list,
          \ 'n_alts': len(spell_list),
          \ }

    if len(b:_spell.alts) > 1
      " Do something to change the buffer and force a new undo point to be
      " created.  This is because `undojoin` is used below and it won't
      " work if we're not at the last point of the undo history.
      if a:visual
        normal! xP
      else
        normal! ix
        normal! x
      endif
    endif
  endif

  if a:visual
    normal! gv
  endif

  if len(b:_spell.alts) < 2
    echo 'Spell Rotate: No suggestions'
    return
  endif

  " Force the next changes to be part of the last undo point
  undojoin

  " Setup vim-repeat if it exists.
  silent! call repeat#set(printf("\<Plug>(SpellRotate%s%s)",
        \ a:dir < 0 ? 'Backward' : 'Forward', a:visual ? 'V' : ''))

  " Get the suggested, previous, and next text
  let i = (b:_spell.index + (a:dir * v:count1)) % b:_spell.n_alts
  if i < 0
    let i += b:_spell.n_alts
  endif

  let next = (i + 1) % b:_spell.n_alts
  let prev = (i - 1) % b:_spell.n_alts
  if prev < 0
    let prev += b:_spell.n_alts
  endif

  let next_word = b:_spell.alts[next]
  let prev_word = b:_spell.alts[prev]

  let b:_spell.index = i
  call setreg(register, b:_spell.alts[i])

  if a:visual
    normal! p`[v`]
  else
    keepjumps normal! gvp
  endif

  " Keep the original word in the unnamed register
  call setreg(register, b:_spell.cword)

  let b:_spell.bounds = [
        \ getpos(a:visual ? "'<" : "'[")[1:2],
        \ getpos(a:visual ? "'>" : "']")[1:2],
        \ ]

  echo 'Spell Rotate ('
  echohl Title
  echon b:_spell.cword
  echohl None
  echon '): '

  if a:dir < 0
    echohl String
  else
    echohl Comment
  endif
  echon prev_word
  echohl None

  echon ' < '

  echohl Keyword
  echon b:_spell.alts[i]
  echohl None

  echon ' > '

  if a:dir > 0
    echohl String
  else
    echohl Comment
  endif
  echon next_word
  echohl None

  redraw
endfunction


function! s:spell_rotate_suball() abort
  if !exists('b:_spell') || len(b:_spell.alts) < 2
    return
  endif
  execute '%s/'.b:_spell.cword.'/'.b:_spell.alts[b:_spell.index].'/g'
endfunction


command! SpellRotateSubAll call s:spell_rotate_suball()

nnoremap <silent> <Plug>(SpellRotateForward) :<c-u>call <sid>spell_rotate(v:count1, 0)<cr>
nnoremap <silent> <Plug>(SpellRotateBackward) :<c-u>call <sid>spell_rotate(-v:count1, 0)<cr>
vnoremap <silent> <Plug>(SpellRotateForwardV) :<c-u>call <sid>spell_rotate(v:count1, 1)<cr>
vnoremap <silent> <Plug>(SpellRotateBackwardV) :<c-u>call <sid>spell_rotate(-v:count1, 1)<cr>

nmap <silent> zz <Plug>(SpellRotateForward)
nmap <silent> zp <Plug>(SpellRotateBackward)
vmap <silent> zz <Plug>(SpellRotateForwardV)
vmap <silent> zp <Plug>(SpellRotateBackwardV)
