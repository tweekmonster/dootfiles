function! s:setup() abort
    omap aa <Plug>SidewaysArgumentTextobjA
    xmap aa <Plug>SidewaysArgumentTextobjA
    omap ia <Plug>SidewaysArgumentTextobjI
    xmap ia <Plug>SidewaysArgumentTextobjI

    nnoremap <silent> ]a :<c-u>SidewaysJumpRight<cr>
    xnoremap <silent> ]a gv:<c-u>SidewaysJumpRight<cr>
    nnoremap <silent> [a :<c-u>SidewaysJumpLeft<cr>
    xnoremap <silent> [a gv:<c-u>SidewaysJumpLeft<cr>
endfunction

augroup vimrc_sideways
  autocmd!
  autocmd VimEnter * call s:setup()
augroup END
