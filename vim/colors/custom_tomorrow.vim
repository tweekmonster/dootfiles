call colorpal#begin()
set background=dark
highlight clear
if exists('syntax_on')
  syntax reset
endif

let g:colors_name = 'custom_tomorrow'
let g:terminal_color_0  = '#000000'
let g:terminal_color_1  = '#ff5555'
let g:terminal_color_2  = '#50fa7b'
let g:terminal_color_3  = '#f1fa8c'
let g:terminal_color_4  = '#bd93f9'
let g:terminal_color_5  = '#ff79c6'
let g:terminal_color_6  = '#8be9fd'
let g:terminal_color_7  = '#f8f8f2'
let g:terminal_color_8  = '#555555'
let g:terminal_color_9  = '#ff5555'
let g:terminal_color_10  = '#50fa7b'
let g:terminal_color_11  = '#f1fa8c'
let g:terminal_color_12  = '#bd93f9'
let g:terminal_color_13  = '#ff79c6'
let g:terminal_color_14  = '#8be9fd'
let g:terminal_color_15  = '#f8f8f2'

" Vim editor colors
CPHL PMenu gray4 gray2,multiply(white,20)
CPHL PMenuSel gray0 yellow,bright
CPHL PMenuSbar - gray0
CPHL PMenuThumb - gray4

CPHL Normal gray5 #080808 -
CPHL Cursor gray0 gray5 -
CPHL LineNr gray3 gray1 -
CPHL SignColumn gray3 gray1 -
CPHL EndOfBuffer gray3 - -

" GitGutter highlighting
CPHL! GitGutterAdd green gray1 -
CPHL! GitGutterChange orange,bright gray1 -
CPHL! GitGutterDelete red gray1 underline
CPHL! GitGutterChangeDelete red,light gray1 underline

CPHL ColorColumn - gray1,dark none
CPHL CursorColumn - gray1 none
CPHL CursorLine none none none
CPHL CursorLineNr gray0 yellow,bright -

CPHL MatchParen cyan gray2 -

CPHL Bold - - bold
CPHL Debug red - -
CPHL Directory blue - -
CPHL Error gray0 red -
CPHL ErrorMsg red gray0 -
CPHL Exception red - -
CPHL FoldColumn cyan gray1 -
CPHL Folded gray3 gray1 -
CPHL IncSearch yellow,bright gray2 none
CPHL Italic - - none
CPHL Macro red - -
CPHL ModeMsg green - -
CPHL MoreMsg green - -
CPHL Question blue - -
CPHL Search green,bright gray2 italic
CPHL SpecialKey gray3 - -
CPHL TooLong red - -
CPHL Underlined red - -
CPHL Visual - gray2 -
CPHL VisualNOS red - -
CPHL WarningMsg orange,w+=20 - -
CPHL WildMenu red - -
CPHL Title blue - none
CPHL Conceal blue gray0 -
CPHL NonText gray3 - -
CPHL StatusLine gray4 gray2 none
CPHL StatusLineNC gray3 gray1 none
CPHL VertSplit gray2 gray2 none

CPHL TabLine gray3 gray1 none
CPHL TabLineFill gray3 gray1 none
CPHL TabLineSel green gray1 none

" Standard syntax highlighting
CPHL Comment gray3 - italic

CPHL Boolean orange,w+=20 - -
CPHL Character red - -
CPHL Conditional violet - -
CPHL Constant orange - -
CPHL Define violet - none
CPHL Delimiter brown - -
CPHL Float orange - -
CPHL Function blue,bright - -
CPHL Identifier red,light - none
CPHL Include blue - -
CPHL Keyword violet - -
CPHL Label yellow - -
CPHL Number orange - -
CPHL Operator gray5 - none
CPHL PreProc yellow - -
CPHL Repeat yellow - -
CPHL Special cyan - -
CPHL SpecialChar brown - -
CPHL Statement red - -
CPHL StorageClass yellow - -
CPHL String green - -
CPHL Structure violet - -
CPHL Tag yellow - -
CPHL Todo yellow gray1 -
CPHL Type yellow - none
CPHL Typedef yellow - -

" Neomake Highlighting
CPHL NeomakeWarn yellow gray1
CPHL NeomakeErr red gray1

" C highlighting
CPHL cOperator cyan - -
CPHL cPreCondit violet - -

" C# highlighting
CPHL csClass yellow - -
CPHL csAttribute yellow - -
CPHL csModifier violet - -
CPHL csType red - -
CPHL csUnspecifiedStatement blue - -
CPHL csContextualStatement violet - -
CPHL csNewDecleration red - -

" CSS highlighting
CPHL cssBraces gray5 - -
CPHL cssClassName violet - -
CPHL cssColor cyan - -
CPHL cssVendor cyan - -
CPHL link scssProperty cssProp
CPHL link cssPseudoClass PreProc

" Diff highlighting
CPHL DiffAdd - blue,multiply(black,75)
CPHL DiffChange - yellow,s-15,multiply(black,80)
CPHL DiffText cyan,bright yellow,multiply(black,60) underline
CPHL DiffDelete gray1 gray0

" Git highlighting
CPHL gitCommitOverflow red - -
CPHL gitCommitSummary green - -

" HTML highlighting
CPHL htmlBold yellow - -
CPHL htmlItalic violet - -
CPHL htmlEndTag gray5 - -
CPHL htmlTag gray5 - -

" JavaScript highlighting
CPHL javaScript gray5 - -
CPHL javaScriptBraces gray5 - -
CPHL javaScriptNumber orange - -

" Mail highlighting
CPHL mailQuoted1 yellow - -
CPHL mailQuoted2 green - -
CPHL mailQuoted3 violet - -
CPHL mailQuoted4 cyan - -
CPHL mailQuoted5 blue - -
CPHL mailQuoted6 yellow - -
CPHL mailURL blue - -
CPHL mailEmail blue - -

" Markdown highlighting
CPHL markdownCode green - -
CPHL markdownError gray5 gray0 -
CPHL markdownCodeBlock green - -
CPHL markdownHeadingDelimiter blue - -

" NERDTree highlighting
CPHL NERDTreeDirSlash blue - -
CPHL NERDTreeExecFile gray5 - -

" PHP highlighting
CPHL phpMemberSelector gray5 - -
CPHL phpComparison gray5 - -
CPHL phpParent gray5 - -

" Python highlighting
CPHL link pythonOperator Special
CPHL pythonRepeat violet - -

" Ruby highlighting
CPHL rubyAttribute blue - -
CPHL rubyConstant yellow - -
CPHL rubyInterpolation green - -
CPHL rubyInterpolationDelimiter brown - -
CPHL rubyRegexp cyan - -
CPHL rubySymbol green - -
CPHL rubyStringDelimiter green - -

" SASS highlighting
CPHL sassidChar red - -
CPHL sassClassChar orange - -
CPHL sassInclude violet - -
CPHL sassMixing violet - -
CPHL sassMixinName blue - -

" Signify highlighting
CPHL SignifySignAdd green gray1 -
CPHL SignifySignChange blue gray1 -
CPHL SignifySignDelete red gray1 -

" Spelling highlighting
CPHL SpellBad - red,multiply(black,70) underline
CPHL SpellLocal - green,multiply(black,70) underline
CPHL SpellCap - orange,multiply(black,70) underline
CPHL SpellRare - cyan,multiply(black,70) underline

" Help
CPHL helpExample blue,light - -
CPHL helpCommand orange - -

" Braceless
CPHL BracelessIndent cyan,dark - inverse

" ImpSort
CPHL pythonImportedObject yellow,bright,bright,c-30 - bold
CPHL pythonImportedFuncDef cyan,dark - bold
CPHL pythonImportedClassDef yellow,dark - bold


" BufTabLine
CPHL BufTabLineCurrent gray2 green
CPHL BufTabLineActive gray0 green,l-=.5,s-=.5
CPHL BufTabLineHidden gray4 gray2
CPHL BufTabLineFill - gray1

CPHL CursorWord - blue,multiply(black,85),light underline
CPHL Halo - violet,multiply(black,70) -
CPHL QuickFixLine gray0 cyan,bright
