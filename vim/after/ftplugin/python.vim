let g:python_highlight_all = 1
let g:braceless_generate_scripts = 1
let b:delimitMate_nesting_quotes = ['"', "'"]

setlocal completeopt-=preview
setlocal textwidth=79
setlocal shiftwidth=4
setlocal tabstop=4
setlocal softtabstop=4

BracelessEnable +indent +fold-inner +highlight-cc2
