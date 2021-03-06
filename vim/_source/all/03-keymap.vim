let mapleader=","

function! s:cmdalias(lhs, rhs) abort
  execute 'cmap <expr> '.a:lhs.' getcmdtype()=='':'' && getcmdpos()==1 ? "'.a:rhs.'" : "'.a:lhs.'"'
endfunction

" Buffer-local file editing

" Show syntax groups
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
      \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
      \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
imap <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
      \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
      \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>


" jk is escape, THEN move to the right to preserve the cursor position, unless
" at the first column.  <esc> will continue to work the default way.
inoremap <expr> jk col('.') == 1 ? '<esc>' : '<esc>l'
imap JK jk
imap Jk jk

imap <Nul> <Space>

" Highlight last inserted text
nnoremap gV `[v`]

nnoremap <silent> <leader>q :<c-u>Sayonara!<cr>

" Profiling
nnoremap <silent> <leader>DD :exe ":profile start profile.log"<cr>:exe ":profile func *"<cr>:exe ":profile file *"<cr>
nnoremap <silent> <leader>DQ :exe ":profile pause"<cr>:noautocmd qall!<cr>

function! s:autospell()
  let sp = &spell
  set spell
  let cword = expand('<cword>')
  let suggestions = spellsuggest(cword)
  let selection = inputlist(['Change "'.cword.'" to:'] +
        \ map(copy(suggestions), 'printf("%2d. \"%s\"", v:key + 1, v:val)'))
  if selection
    execute 'normal! ciw'.suggestions[selection - 1]
  endif
  let &spell = sp
endfunction

nnoremap z= :<c-u>call <sid>autospell()<cr>

" Visual range macros
function! s:visual_range_macro()
  echo "@".getcmdline()
  execute ":'<,'>normal! @".nr2char(getchar())
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
  if exists('g:loaded_tcomment') && tcomment#TypeExists(&filetype) != ''
    let l:commentstring = tcomment#GetCommentDef(&filetype).commentstring
  endif
  let l:modeline = printf(l:commentstring, l:modeline)
  call append(line("$"), l:modeline)
endfunction

nnoremap <silent> <leader>ml :call <sid>append_mode_line()<cr>

" dotfiles vim config editing
nnoremap <localleader>v :<c-u>execute 'Files '.expand('$DOTFILES/vim')<cr>

" Undotree
nnoremap <silent> <leader>u :<c-u>UndotreeToggle<cr>:UndotreeFocus<cr>

" Inserting dates
nnoremap <localleader>d a<c-r>=join(systemlist('date -Iseconds'), '')<cr><esc>
vnoremap <localleader>d c<c-r>=join(systemlist('date -Iseconds'), '')<cr><esc>

nnoremap <silent> <space> :<c-u>call halo#run({'shape': 'line'})<cr>

function! s:copy_url(mode) abort
  if a:mode == 'v'
    let save_reg = getreg('u')
    let save_regtype = getregtype('u')
    normal! gv"uygv
    let word = getreg('u')
    call setreg('u', save_reg, save_regtype)
  else
    let word = expand('<cWORD>')
    let word = matchstr(word, 'https\?:\/\/\(\w\+\(:\w\+\)\?@\)\?'
          \ .'\([A-Za-z][-_0-9A-Za-z]*\.\)\{1,}\(\w\{2,}\.\?\)\{1,}'
          \ .'\(:[0-9]\{1,5}\)\?\([-./%?+=]\|\w\)\+')
    if empty(word)
      let word = expand('<cword>')
    endif
  endif

  if empty(word)
    return
  endif

  if word !~# '^https\?:'
    let word = substitute(word, '\w\@!.', '\=printf("%%%02x", char2nr(submatch(0)))', 'g')
    let word = 'https://www.google.com/search?q='.word
  endif

  call setreg('+', 'sshclip-url:'.word, 'c')
  echomsg word
endfunction

nnoremap <silent> gx :call <sid>copy_url('n')<cr>
vnoremap <silent> gx :<c-u>call <sid>copy_url('v')<cr>
