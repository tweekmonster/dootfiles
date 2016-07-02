let s:enable_debug = 0
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_ignore_case = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#file#enable_buffer_path = 1
let g:deoplete#auto_complete_start_length = 1
let g:deoplete#sources#jedi#short_types = 1
let g:deoplete#sources#jedi#statement_length = 80
let g:deoplete#max_list = 300


function! s:setup_deoplete() abort
  if s:enable_debug
    let g:deoplete#sources#jedi#debug_enabled = 1
    call deoplete#enable_logging('DEBUG', expand('$XDG_RUNTIME_DIR/deoplete.log'))
  endif
  call deoplete#custom#set('_', 'converters',
        \ ['converter_auto_paren', 'converter_remove_overlap'])
  call deoplete#custom#set('vim', 'converters',
        \ ['add_vim_versions'])
  call deoplete#custom#set('_', 'matchers', ['matcher_fuzzy'])
endfunction


augroup vimrc_deoplete
  autocmd!
  autocmd VimEnter * call s:setup_deoplete()
augroup END
