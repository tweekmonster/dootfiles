let g:vimfiler_as_default_explorer = 1
call vimfiler#custom#profile('default', 'context', {
      \     'safe': 0,
      \ })
let g:vimfiler_ignore_pattern = '\(\.git\|__pycache__\|\.pyc\|\.DS_Store$\)'
let g:vimfiler_tree_leaf_icon = ' '
let g:vimfiler_tree_opened_icon = '▾'
let g:vimfiler_tree_closed_icon = '▸'
let g:vimfiler_file_icon = '-'
let g:vimfiler_marked_file_icon = '*'


augroup vimrc_vimfiler
  autocmd!
  autocmd FileType vimfiler nmap <buffer> q Q
  autocmd FileType vimfiler set nonumber norelativenumber
  autocmd BufEnter * if (winnr('$') == 1 && &filetype ==# 'vimfiler') | q | endif
augroup END

nnoremap <silent> <leader>v :VimFiler -find -project -split -simple -winwidth=35 -toggle -force-quit -edit-action=choose<CR>
