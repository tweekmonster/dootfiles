let s:enable_debug = 0
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_ignore_case = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#file#enable_buffer_path = 1
let g:deoplete#auto_complete_start_length = 1
let g:deoplete#sources#jedi#short_types = 1
let g:deoplete#sources#jedi#statement_length = 80
let g:deoplete#max_list = 300
let g:deoplete#auto_complete_delay = 150
let deoplete#tag#cache_limit_size = 5000000

let g:deoplete#sources#go#auto_goos = 1
let g:deoplete#sources#jedi#debug_server = 0
let g:deoplete#sources#clang#autofill_neomake = 1


function! s:setup_deoplete() abort
  if exists('s:enable_debug') && s:enable_debug
    call deoplete#custom#set('deoplete', 'debug_enabled', 1)
    call deoplete#custom#set('clang2', 'debug_enabled', 0)
    call deoplete#custom#set('buffer', 'debug_enabled', 0)
    call deoplete#custom#set('django', 'debug_enabled', 1)
    call deoplete#custom#set('jedi', 'debug_enabled', 1)
    call deoplete#custom#set('go', 'debug_enabled', 1)
    call deoplete#enable_logging('DEBUG', expand('$XDG_RUNTIME_DIR/deoplete.log'))
  endif

  call deoplete#custom#set('clang2', 'converters',
        \ ['converter_remove_overlap'])
  call deoplete#custom#set('_', 'converters',
        \ ['converter_auto_paren', 'converter_remove_overlap'])
  call deoplete#custom#set('vim', 'converters',
        \ ['add_vim_versions'])
  call deoplete#custom#set('_', 'matchers', ['matcher_fuzzy'])
endfunction


augroup vimrc_deoplete
  autocmd!
  autocmd VimEnter * try | call s:setup_deoplete() | catch | endtry
augroup END
