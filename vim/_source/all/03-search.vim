" Removes the search highlight on insert mode and restores it in normal mode
function! s:toggle_highlight()
  if exists('g:_last_search')
    let @/ = g:_last_search
    unlet g:_last_search
  else
    let g:_last_search = @/
    let @/ = ''
  endif
endfunction


function! s:star_search(key) abort
  let out = '?\<\k\{-}\%#'."\<cr>"
  let key = a:key

  if mode() ==? 'v'
    let out = '"vy'
    let key = (a:key == '*' ? '/' : '?') . "\<c-r>="
          \. 'substitute(escape(@v, ''/\.*$^~[''), ''\_s\+'', ''\\_s\\+'', ''g'')'
          \. "\<cr>\<cr>"
  endif

  return out.":\<c-u>"
        \. join([
        \   ':let g:_view = winsaveview()',
        \   ':let g:_pos = getpos(''.'')[1:2]'], "\<cr>")."\<cr>"
        \   .key.
        \   join([':call cursor(g:_pos)',
        \   ':call winrestview(g:_view)',
        \   ':set hlsearch'], "\<cr>")."\<cr>"
endfunction


function! s:search_scroll(key, ...) abort
  execute "normal! " . a:key

  let l = line('.')
  let t = line('w0')
  let b = t + winheight(winnr())
  let p = (b - t) / 4
  let scroll = ''

  if l < t + p
    let scroll = (p - (l - t))."\<c-y>"
  elseif l > b - p
    let scroll = (p - (b - l))."\<c-e>"
  endif

  if !empty(scroll)
    execute 'normal!' scroll
  endif
endfunction


function! s:highlight_cursor_word() abort
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


augroup vimrc_search
  autocmd!
  autocmd CursorMoved * call s:highlight_cursor_word()
  autocmd InsertEnter * call s:toggle_highlight()
  autocmd InsertLeave * call s:toggle_highlight()
augroup END


highlight default CursorWord gui=underline cterm=underline


nnoremap <silent><expr> * <sid>star_search('*')
nnoremap <silent><expr> # <sid>star_search('#')
vnoremap <silent><expr> * <sid>star_search('*')
vnoremap <silent><expr> # <sid>star_search('#')
nnoremap <silent> n :<c-u>call <sid>search_scroll('n')<cr>
nnoremap <silent> N :<c-u>call <sid>search_scroll('N')<cr>

nnoremap <silent> <leader><space> :<c-u>let v:hlsearch=!v:hlsearch<cr>
