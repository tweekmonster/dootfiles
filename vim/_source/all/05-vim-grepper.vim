nnoremap <leader>* *:execute 'Grepper -tool pt -query -w '.matchstr(@/, '\\<\zs.*\ze\\>')<cr>
vnoremap <leader>* "vy/<c-r>='\<'.@v.'\>'<cr><cr>:execute "Grepper -tool pt -noprompt -query -w '".@v."'"<cr>
