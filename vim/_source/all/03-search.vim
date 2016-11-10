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


augroup vimrc_search
  autocmd!
  autocmd InsertEnter * call s:toggle_highlight()
  autocmd InsertLeave * call s:toggle_highlight()
augroup END


nnoremap <silent><expr> * <sid>star_search('*')
nnoremap <silent><expr> # <sid>star_search('#')
vnoremap <silent><expr> * <sid>star_search('*')
vnoremap <silent><expr> # <sid>star_search('#')
nnoremap <silent> n :<c-u>call <sid>search_scroll('n')<cr>
nnoremap <silent> N :<c-u>call <sid>search_scroll('N')<cr>

nnoremap <silent> <leader><space> :<c-u>let v:hlsearch=!v:hlsearch<cr>
