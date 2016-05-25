let g:surround_49 = "‘\r’"
let g:surround_50 = "“\r”"
let g:surround_51 = "'''\r'''"
let g:surround_52 = '"""\r"""'
execute 'let g:surround_'.char2nr('i').'="\1array: \1[\r]"'
