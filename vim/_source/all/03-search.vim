" This keeps the cursor in place when using * or #
function! s:star_search(key) abort
  let g:_view = winsaveview()
  let out = a:key

  if mode() ==? 'v'
    let out = '"vy' . (a:key == '*' ? '/' : '?') . "\<c-r>="
          \. 'substitute(escape(@v, ''/\.*$^~[''), ''\_s\+'', ''\\_s\\+'', ''g'')'
          \. "\<cr>\<cr>"
  endif

  return out."N:\<c-u>"
        \   .join(['let g:_pos = getpos(''.'')[1:2]',
        \   ':call winrestview(g:_view)',
        \   ':call cursor(g:_pos)',
        \   ':set hlsearch',
        \   ':unlet! g:_view',
        \   ':unlet! g:_pos'], "\<cr>")."\<cr>"
endfunction


nnoremap <silent><expr> * <sid>star_search('*')
nnoremap <silent><expr> # <sid>star_search('#')
vnoremap <silent><expr> * <sid>star_search('*')
vnoremap <silent><expr> # <sid>star_search('#')


" This tries to keep the cursor away from the window edges when traversing
" search matches.
function! s:search_scroll(key, ...) abort
  let old_so = &scrolloff
  let old_sso = &sidescrolloff
  set scrolloff=10 sidescrolloff=10
  try
    execute 'normal!' a:key
  catch
  endtry
  let &scrolloff = old_so
  let &sidescrolloff = old_sso

  let lnum = line('.')
  let bottom = line('w0') + winheight(winnr()) - 1
  if lnum + 10 > bottom
    execute printf("normal! %d\<c-e>", (lnum + 10) - bottom)
  endif
endfunction


nnoremap <silent> n :<c-u>call <sid>search_scroll('n')<cr>
nnoremap <silent> N :<c-u>call <sid>search_scroll('N')<cr>


" Highlights the word under the cursor.  If in the vim filetype, matching
" s: and <sid> functions will be highlighted.
function! s:highlight_cursor_word(...) abort
  if &filetype =~# 'help\|qf'
    return
  endif

  unlet! w:_cword_timer
  let vimkey = 0
  let pat = '\k*\%'.col('.').'c\@<=\k\k*'
  if &filetype == 'vim'
    let pat = '\%(<sid>\|[bwtglsav]:\)\?'.pat
    if synIDattr(synID(line('.'), col('.'), 0), 'name') =~# 'vimMapModKey\|vimNotation'
      let vimkey = 1
      let pat = '<\?'.pat.'>\?'
    endif
  endif

  let word = matchstr(getline('.'), pat)
  if get(w:, '_cword', '') != word
    silent! call matchdelete(w:_cword_id)
    let w:_cword = word

    if !empty(word)
      let word = escape(word, '^$.\[]*')
      if word =~? '^\%(<sid>\|s:\)'
        let word = '\%(<sid>\|s:\)'.matchstr(word, '^\%(<sid>\|s:\)\zs.*').'\>'
      elseif !vimkey
        let word = '\<'.word.'\>'
      endif

      let w:_cword_id = matchadd('CursorWord', word, -1)
    endif
  endif
endfunction


function! s:highlight_cursor_word_timer() abort
  if exists('w:_cword_timer')
    call timer_stop(w:_cword_timer)
  endif

  let w:_cword_timer = timer_start(100, function('s:highlight_cursor_word'))
endfunction


augroup vimrc_search
  autocmd!
  autocmd CursorMoved * call s:highlight_cursor_word_timer()
  autocmd InsertEnter * set nohlsearch
  autocmd InsertLeave * set hlsearch
augroup END


highlight default CursorWord gui=underline cterm=underline


nnoremap <silent> <leader><space> :<c-u>let v:hlsearch=!v:hlsearch<cr>
