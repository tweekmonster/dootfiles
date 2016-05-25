let g:airline#themes#base16_custom#palette = {}
let s:p = base16#palette()


function! s:pal(fg, bg)
  return [s:p['gui'.a:fg], s:p['gui'.a:bg], s:p['cterm'.a:fg], s:p['cterm'.a:bg]]
endfunction

let s:airline_pal = {}

let s:airline_pal.normal = airline#themes#generate_color_map(s:pal('01', '0B'), s:pal('06', '02'), s:pal('09', '01'))
let s:airline_pal.insert = airline#themes#generate_color_map(s:pal('01', '0D'), s:pal('06', '02'), s:pal('09', '01'))
let s:airline_pal.replace = airline#themes#generate_color_map(s:pal('01', '08'), s:pal('06', '02'), s:pal('09', '01'))
let s:airline_pal.visual = airline#themes#generate_color_map(s:pal('01', '0E'), s:pal('06', '02'), s:pal('09', '01'))
let s:airline_pal.inactive = airline#themes#generate_color_map(s:pal('07', '02'), s:pal('07', '02'), s:pal('07', '02'))

let g:airline#themes#base16_custom#palette = s:airline_pal
