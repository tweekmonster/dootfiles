let g:colorpal_write_syncolor = 1
let g:colorpal_palette = {
      \   'black': '000000',
      \   'white': 'ffffff',
      \   'gray0': "1d1f21",
      \   'gray1': "282a2e",
      \   'gray2': "373b41",
      \   'gray3': "969896",
      \   'gray4': "b4b7b4",
      \   'gray5': "c5c8c6",
      \   'gray6': "e0e0e0",
      \   'gray7': "ffffff",
      \   'red': "cc6666",
      \   'orange': "de935f",
      \   'yellow': "f0c674",
      \   'green': "b5bd68",
      \   'cyan': "8abeb7",
      \   'blue': "81a2be",
      \   'violet': "b294bb",
      \   'brown': "a3685a",
      \ }

let g:colorpal_airline = {
      \ 'normal': [['gray1', 'green'], ['gray6', 'gray2'], ['green,light', 'gray1']],
      \ 'insert': [['gray1', 'cyan'], ['gray6', 'gray2'], ['orange', 'gray1']],
      \ 'replace': [['gray1', 'red'], ['gray6', 'gray2'], ['orange', 'gray1']],
      \ 'visual': [['gray1', 'violet'], ['gray6', 'gray2'], ['orange', 'gray1']],
      \ 'inactive': [['gray7', 'gray2'], ['gray7', 'gray2'], ['gray7', 'gray2']],
      \ }

colorscheme custom_tomorrow
