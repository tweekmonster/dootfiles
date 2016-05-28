let g:python_highlight_all = 1
let g:braceless_generate_scripts = 1
let b:delimitMate_nesting_quotes = ['"', "'"]

setlocal completeopt-=preview
setlocal textwidth=79
setlocal shiftwidth=4
setlocal tabstop=4
setlocal softtabstop=4

cabbrev <buffer> isort %!isort -y -
nnoremap <buffer><silent> <leader>i :<c-u>call pypreamble#edit_preamble()<cr>

BracelessEnable +indent +fold-inner +highlight-cc2
