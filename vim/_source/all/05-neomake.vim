let g:neomake_error_sign = {
      \   'text': '✕',
      \   'texthl': 'NeomakeErr',
      \ }

let g:neomake_warning_sign = {
      \   'text': '⚠️',
      \   'texthl': 'NeomakeWarn',
      \ }


function! s:fuck_your_opinion_about_star_imports_flake8(entry) abort
  if a:entry.text =~# '401' && a:entry.text =~# '\.\*'
    let a:entry.valid = 0
  endif
endfunction

function! s:fuck_your_opinions_too_golint(entry) abort
  " Oh yes, please tell me about how I should add a comment to exported error
  " variables that are the epitome of 'self explanatory' with a verbose name
  " and message.
  if a:entry.text =~? '\<exported\>.*\<should\>.*\<comment\>'
        \ || a:entry.text =~# 'Id.*\<should\>.*ID'
    let a:entry.valid = 0
  endif
endfunction

let g:neomake_go_golint_maker = {
      \ 'postprocess': function('s:fuck_your_opinions_too_golint'),
      \ }

let g:neomake_python_flake8_maker = {
      \   'args': ['--ignore=E501,E226,C901,E402,F403,F405'],
      \   'postprocess': function('s:fuck_your_opinion_about_star_imports_flake8'),
      \ }

let g:neomake_go_golint_maker = {
      \ 'postprocess': function('s:fuck_your_opinions_too_golint'),
      \ }

augroup vimrc_neomake
  autocmd!
  autocmd BufWritePost * silent Neomake
  autocmd VimLeave * let g:neomake_verbose = 0
augroup END
