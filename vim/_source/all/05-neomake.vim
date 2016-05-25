let g:neomake_error_sign = {
      \   'text': '✕',
      \   'texthl': 'NeomakeErr',
      \ }

let g:neomake_warning_sign = {
      \   'text': '⚠️',
      \   'texthl': 'NeomakeWarn',
      \ }

let g:neomake_python_flake8_maker = {
      \    'args': ['--ignore=E501,E226,F403,C901,E402'],
      \ }

augroup vimrc_neomake
  autocmd!
  autocmd BufWritePost * silent Neomake
augroup END
