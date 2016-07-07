nnoremap <leader>* *:Grepper -tool pt -cword -noprompt<cr>
vnoremap <leader>* "vy/<c-r>=@v<cr><cr>:execute "Grepper -tool pt -noprompt -query '".@v."'"<cr>
