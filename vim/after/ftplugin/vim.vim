" Text block objects, under bundled directory
call vim#blockobj#setup()

inoremap <buffer><expr> <cr> getline(line('.') + 1) =~# '^\s*\\' ? "\<cr>".matchstr(getline('.'), '\\\s*') : "\<cr>"
nmap <buffer> o A<cr>
nmap <expr><buffer> O line('.') == 1 ? 'O' : "kA\<cr>"
