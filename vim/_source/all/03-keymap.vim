let mapleader=","

function! s:cmdalias(lhs, rhs) abort
  execute 'cmap <expr> '.a:lhs.' getcmdtype()=='':'' && getcmdpos()==1 ? "'.a:rhs.'" : "'.a:lhs.'"'
endfunction

" Fat fingers
call s:cmdalias('w;', ":echoe 'NO!'\<cr>")
call s:cmdalias('w''', ":echoe 'NO!'\<cr>")
call s:cmdalias('w/', ":echoe 'NO!'\<cr>")

" Sudo write
call s:cmdalias('w!!', 'w !sudo tee > /dev/null %')

" Buffer-local file editing
call s:cmdalias('e/', 'e %:p:h/')

" Show syntax groups
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
      \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
      \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
imap <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
      \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
      \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>


nnoremap <leader><space> :nohlsearch<cr>

" jk is escape, THEN move to the right to preserve the cursor position, unless
" at the first column.  <esc> will continue to work the default way.
inoremap <expr> jk col('.') == 1 ? '<esc>' : '<esc>l'
imap JK jk
imap Jk jk

" Navigate lines as shown on the screen
nnoremap j gj
nnoremap k gk

imap <Nul> <Space>

" No idea what's causing it, but pressing <esc> leads to a delay, possibly
" waiting for more keys.  I'm not having it.
inoremap <nowait> <esc> <esc>

" Highlight last inserted text
nnoremap gV `[v`]

" Delete a buffer
function! s:delete_buffer() abort
  if &l:modified
    echohl ErrorMsg
    echomsg 'File is modified'
    echohl None
    return
  endif

  let bufcount = len(filter(range(1, bufnr('$')), 'buflisted(v:val)'))
  if bufcount == 1
    return
  endif

  bprevious
  split
  bnext
  bdelete
endfunction

nnoremap <silent> <leader>q :<c-u>call <sid>delete_buffer()<cr>

" Profiling
nnoremap <silent> <leader>DD :exe ":profile start profile.log"<cr>:exe ":profile func *"<cr>:exe ":profile file *"<cr>
nnoremap <silent> <leader>DQ :exe ":profile pause"<cr>:noautocmd qall!<cr>

" Visual * search
vnoremap <silent> * :<C-U>
      \ let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
      \ gvy/<C-R><C-R>=substitute(
      \ escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
      \ gV:call setreg('"', old_reg, old_regtype)<CR>

" Visual range macros
function! s:visual_range_macro()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction

xnoremap @ :<C-u>call <sid>visual_range_macro()<CR>

" Whitespace
function! s:strip_white_space()
  let _s=@/
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  let @/=_s
  call cursor(l, c)
endfunction

nnoremap <silent> <leader>sws :call <sid>strip_white_space()<cr>

" Modeline
function! s:append_mode_line()
  let l:modeline = printf(' vim: set ft=%s ts=%d sw=%d tw=%d %set :',
        \ &filetype, &tabstop, &shiftwidth, &textwidth, &expandtab ? '' : 'no')
  let l:commentstring = &commentstring
  if tcomment#TypeExists(&filetype) != ''
    let l:commentstring = tcomment#GetCommentDef(&filetype).commentstring
  endif
  let l:modeline = printf(l:commentstring, l:modeline)
  call append(line("$"), l:modeline)
endfunction

nnoremap <silent> <leader>ml :call <sid>append_mode_line()<cr>

" dotfiles vim config editing
nnoremap <localleader>v :<c-u>execute 'Files '.expand('$DOTFILES/vim')<cr>
