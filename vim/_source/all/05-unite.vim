let g:unite_enable_start_insert = 1
let g:unite_split_rule = "topleft"
let g:unite_force_overwrite_statusline = 1
let g:unite_winheight = 10

call unite#custom_source('file_rec/async,file_mru,file,buffer,grep',
      \   'ignore_pattern', join([
      \   '\.git/',
      \ ], '\|'))

call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])
call unite#custom#profile('default', 'context', {
      \   'cursor_line_highlight': 'CursorLine',
      \ })

function! s:unite_settings()
  let b:SuperTabDisabled=1
  imap <buffer> <C-j> <Plug>(unite_select_next_line)
  imap <buffer> <C-k> <Plug>(unite_select_previous_line)
  imap <silent><buffer><expr> <C-x> unite#do_action('split')
  imap <silent><buffer><expr> <C-v> unite#do_action('vsplit')
  imap <silent><buffer><expr> <C-t> unite#do_action('tabopen')
endfunction

augroup vimrc_unite
  autocmd!
  autocmd FileType unite call s:unite_settings()
augroup END
