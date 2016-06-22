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

let g:neomake_python_flake8_maker = {
      \   'args': ['--ignore=E501,E226,C901,E402,F403,F405'],
      \   'postprocess': function('s:fuck_your_opinion_about_star_imports_flake8'),
      \ }

augroup vimrc_neomake
  autocmd!
  autocmd BufWritePost * silent Neomake
  autocmd QuitPre * let g:neomake_verbose = 0
augroup END
