let g:neomake_highlight_columns = 1
let g:neomake_highlight_lines = 0

silent! call neomake#quickfix#enable()

let g:neomake_go_go_maker = neomake#makers#ft#go#go()
function! g:neomake_go_go_maker.postprocess(entry) abort
  if a:entry.bufnr != bufnr('%')
    " Don't display messages that aren't about the current buffer.
    let a:entry.valid = -1
  endif
endfunction

let g:neomake_python_flake8_maker = neomake#makers#ft#python#flake8()
function! g:neomake_python_flake8_maker.postprocess(entry) abort
  if a:entry.nr == 501 || a:entry.nr == 401 || a:entry.nr == 405
    let a:entry.valid = -1
    return
  endif

  call neomake#makers#ft#python#Flake8EntryProcess(a:entry)
endfunction

let g:neomake_python_enabled_makers = ['flake8']

let g:neomake_vcl_varnish_maker = {
      \ 'exe': 'varnishd',
      \ 'args': ['-C', '-n', '/tmp', '-f', '%:p'],
      \ 'append_file': 0,
      \ 'errorformat': '%EMessage from VCC-compiler:,%Z(''%f'' Line %l Pos %c),%+C%.%#,%-G%.%#',
      \ }

let g:neomake_vcl_enabled_makers = ['varnish']
let g:neomake_objc_enabled_makers = ['clang']

" let g:nvimdev_auto_cscope = 1
" silent! set cscopequickfix=s-,c-,d-,i-,t-,e-,a-

augroup vimrc_neomake
  autocmd!
  autocmd BufWritePost * silent Neomake
  autocmd VimLeave * let g:neomake_verbose = 0
augroup END
