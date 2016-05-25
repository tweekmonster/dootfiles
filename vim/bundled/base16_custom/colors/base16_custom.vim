" Base16 Custom
" Base16 Tomorrow (https://github.com/chriskempson/base16)
" Scheme: Chris Kempson (http://chriskempson.com)
" Modified to use the system palette

hi clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "base16_custom"

let s:p = base16#palette()


" Highlighting function
function! <sid>hi(group, guifg, guibg, ctermfg, ctermbg, attr)
  if a:guifg != ""
    exec "hi " . a:group . " guifg=#" . s:p.gui(a:guifg)
  endif
  if a:guibg != ""
    exec "hi " . a:group . " guibg=#" . s:p.gui(a:guibg)
  endif
  if a:ctermfg != ""
    exec "hi " . a:group . " ctermfg=" . s:p.cterm(a:ctermfg)
  endif
  if a:ctermbg != ""
    exec "hi " . a:group . " ctermbg=" . s:p.cterm(a:ctermbg)
  endif
  if a:attr != ""
    exec "hi " . a:group . " gui=" . a:attr . " cterm=" . a:attr
  endif
endfunction


" Return GUI color for light/dark variants
function! s:p.gui(color)
  return a:color
  if &background == "dark"
    return a:color
  endif

  if a:color == s:p.gui00
    return s:p.gui07
  elseif a:color == s:p.gui01
    return s:p.gui0
  elseif a:color == s:p.gui02
    return s:p.gui05
  elseif a:color == s:p.gui03
    return s:p.gui04
  elseif a:color == s:p.gui04
    return s:p.gui03
  elseif a:color == s:p.gui05
    return s:p.gui02
  elseif a:color == s:p.gui06
    return s:p.gui01
  elseif a:color == s:p.gui07
    return s:p.gui00
  endif

  return a:color
endfunction


" Return terminal color for light/dark variants
function! s:p.cterm(color)
  return a:color
  if &background == "dark"
    return a:color
  endif

  if a:color == s:p.cterm00
    return s:p.cterm07
  elseif a:color == s:p.cterm01
    return s:p.cterm06
  elseif a:color == s:p.cterm02
    return s:p.cterm05
  elseif a:color == s:p.cterm03
    return s:p.cterm04
  elseif a:color == s:p.cterm04
    return s:p.cterm03
  elseif a:color == s:p.cterm05
    return s:p.cterm02
  elseif a:color == s:p.cterm06
    return s:p.cterm01
  elseif a:color == s:p.cterm07
    return s:p.cterm00
  endif

  return string(a:color)
endfunction


" Vim editor colors
call <sid>hi("Bold",          "", "", "", "", "bold")
call <sid>hi("ColorColumn",   "", s:p.gui01, "", 233, "")
call <sid>hi("Conceal",       s:p.gui02, s:p.gui00, s:p.cterm02, "none", "")
call <sid>hi("CursorColumn",  "", s:p.gui01, "", 233, "none")
call <sid>hi("CursorLineNr",  s:p.gui0A, s:p.gui01, s:p.cterm0A, 234, "")
call <sid>hi("CursorLine",    "", s:p.gui01, "", 234, "none")
call <sid>hi("Cursor",        s:p.gui00, s:p.gui05, s:p.cterm00, s:p.cterm05, "")
call <sid>hi("Debug",         s:p.gui08, "", s:p.cterm08, "", "")
call <sid>hi("Directory",     s:p.gui0D, "", s:p.cterm0D, "", "")
call <sid>hi("ErrorMsg",      s:p.gui08, s:p.gui00, s:p.cterm08, s:p.cterm00, "")
call <sid>hi("Exception",     s:p.gui08, "", s:p.cterm08, "", "")
call <sid>hi("FoldColumn",    "", s:p.gui01, "", s:p.cterm01, "")
call <sid>hi("Folded",        s:p.gui03, s:p.gui01, s:p.cterm03, s:p.cterm01, "")
call <sid>hi("Ignore",        s:p.gui03, "", s:p.cterm03, "", "")
call <sid>hi("IncSearch",     s:p.gui01, s:p.gui09, 201, s:p.cterm01, "italic,underline")
call <sid>hi("Italic",        "", "", "", "", "none")
call <sid>hi("LineNr",        s:p.gui03, s:p.gui01, s:p.cterm03, 234, "")
call <sid>hi("Macro",         s:p.gui08, "", s:p.cterm08, "", "")
call <sid>hi("MatchParen",    s:p.gui0C, s:p.gui02, s:p.cterm0C, s:p.cterm02, "underline")
call <sid>hi("ModeMsg",       s:p.gui0B, "", s:p.cterm0B, "", "")
call <sid>hi("MoreMsg",       s:p.gui0B, "", s:p.cterm0B, "", "")
call <sid>hi("NonText",       s:p.gui02, "", s:p.cterm02, "", "")
" call <sid>hi("Normal",        s:p.gui05, "", s:p.cterm05, 232, "")
call <sid>hi("Normal",        s:p.gui05, "", s:p.cterm05, "none", "")
call <sid>hi("PMenuSel",      s:p.gui01, s:p.gui04, s:p.cterm01, s:p.cterm04, "")
call <sid>hi("PMenu",         s:p.gui04, s:p.gui01, s:p.cterm04, s:p.cterm01, "none")
call <sid>hi("Question",      s:p.gui0D, "", s:p.cterm0D, "", "")
call <sid>hi("Search",        s:p.gui01, s:p.gui0A, 83, s:p.cterm01, "italic,underline")
call <sid>hi("SignColumn",    s:p.gui03, s:p.gui01, s:p.cterm03, s:p.cterm01, "")
call <sid>hi("SpecialKey",    s:p.gui02, "", s:p.cterm02, "", "")
call <sid>hi("StatusLineNC",  s:p.gui03, s:p.gui01, s:p.cterm03, s:p.cterm01, "none")
call <sid>hi("StatusLine",    s:p.gui04, s:p.gui02, s:p.cterm04, s:p.cterm02, "none")
call <sid>hi("TabLineFill",   s:p.gui03, s:p.gui01, s:p.cterm03, s:p.cterm01, "none")
call <sid>hi("TabLineSel",    s:p.gui0B, s:p.gui01, s:p.cterm0B, s:p.cterm01, "none")
call <sid>hi("TabLine",       s:p.gui03, s:p.gui01, s:p.cterm03, s:p.cterm01, "none")
call <sid>hi("Title",         s:p.gui0D, "", s:p.cterm0D, "", "none")
call <sid>hi("TooLong",       s:p.gui08, "", s:p.cterm08, "", "")
call <sid>hi("Underlined",    s:p.gui08, "", s:p.cterm08, "", "")
call <sid>hi("VertSplit",     s:p.gui02, s:p.gui02, s:p.cterm02, s:p.cterm02, "none")
call <sid>hi("VisualNOS",     s:p.gui08, "", s:p.cterm08, "", "")
call <sid>hi("Visual",        "", s:p.gui02, "", s:p.cterm02, "")
call <sid>hi("WarningMsg",    s:p.gui08, "", s:p.cterm08, "", "")
call <sid>hi("WildMenu",      s:p.gui08, "", s:p.cterm08, "", "")

" Standard syntax highlighting
call <sid>hi("Boolean",      s:p.gui09, "", s:p.cterm09, "", "")
call <sid>hi("Character",    s:p.gui08, "", s:p.cterm08, "", "")
call <sid>hi("Comment",      s:p.gui03, "", s:p.cterm03, "", "italic")
call <sid>hi("Conditional",  s:p.gui0E, "", s:p.cterm0E, "", "")
call <sid>hi("Constant",     s:p.gui09, "", s:p.cterm09, "", "")
call <sid>hi("Define",       s:p.gui0E, "", s:p.cterm0E, "", "none")
call <sid>hi("Delimiter",    s:p.gui0F, "", s:p.cterm0F, "", "")
call <sid>hi("Float",        s:p.gui09, "", s:p.cterm09, "", "")
call <sid>hi("Function",     s:p.gui0D, "", s:p.cterm0D, "", "")
call <sid>hi("Identifier",   s:p.gui08, "", s:p.cterm08, "", "none")
call <sid>hi("Include",      s:p.gui0D, "", s:p.cterm0D, "", "")
call <sid>hi("Keyword",      s:p.gui0E, "", s:p.cterm0E, "", "")
call <sid>hi("Label",        s:p.gui0A, "", s:p.cterm0A, "", "")
call <sid>hi("Number",       s:p.gui09, "", s:p.cterm09, "", "")
call <sid>hi("Operator",     s:p.gui05, "", s:p.cterm05, "", "none")
call <sid>hi("PreProc",      s:p.gui0A, "", s:p.cterm0A, "", "")
call <sid>hi("Repeat",       s:p.gui0A, "", s:p.cterm0A, "", "")
call <sid>hi("SpecialChar",  s:p.gui0F, "", s:p.cterm0F, "", "")
call <sid>hi("Special",      s:p.gui0C, "", s:p.cterm0C, "", "")
call <sid>hi("Statement",    s:p.gui08, "", s:p.cterm08, "", "")
call <sid>hi("StorageClass", s:p.gui0A, "", s:p.cterm0A, "", "")
call <sid>hi("String",       s:p.gui0B, "", s:p.cterm0B, "", "")
call <sid>hi("Structure",    s:p.gui0E, "", s:p.cterm0E, "", "")
call <sid>hi("Tag",          s:p.gui0A, "", s:p.cterm0A, "", "")
call <sid>hi("Todo",         s:p.gui0A, s:p.gui01, s:p.cterm0A, s:p.cterm01, "")
call <sid>hi("Typedef",      s:p.gui0A, "", s:p.cterm0A, "", "")
call <sid>hi("Type",         s:p.gui0A, "", s:p.cterm0A, "", "none")

call <sid>hi("NeomakeWarn",  s:p.gui0A, s:p.gui01, s:p.cterm0A, 234, "")
call <sid>hi("NeomakeErr",   s:p.gui08, s:p.gui01, s:p.cterm08, 234, "")

" C highlighting
call <sid>hi("cOperator",   s:p.gui0C, "", s:p.cterm0C, "", "")
call <sid>hi("cPreCondit",  s:p.gui0E, "", s:p.cterm0E, "", "")

" CSS highlighting
call <sid>hi("cssBraces",      s:p.gui05, "", s:p.cterm05, "", "")
call <sid>hi("cssClassName",   s:p.gui0E, "", s:p.cterm0E, "", "")
call <sid>hi("cssColor",       s:p.gui0C, "", s:p.cterm0C, "", "")

" Diff highlighting
call <sid>hi("DiffAdded",    s:p.gui0B, s:p.gui00,  s:p.cterm0B, s:p.cterm00, "")
call <sid>hi("DiffAdd",      s:p.gui0B, s:p.gui01,  s:p.cterm0B, s:p.cterm01, "")
call <sid>hi("DiffChange",   s:p.gui03, s:p.gui01,  s:p.cterm03, s:p.cterm01, "")
call <sid>hi("DiffDelete",   s:p.gui08, s:p.gui01,  s:p.cterm08, s:p.cterm01, "")
call <sid>hi("DiffFile",     s:p.gui08, s:p.gui00,  s:p.cterm08, s:p.cterm00, "")
call <sid>hi("DiffLine",     s:p.gui0D, s:p.gui00,  s:p.cterm0D, s:p.cterm00, "")
call <sid>hi("DiffNewFile",  s:p.gui0B, s:p.gui00,  s:p.cterm0B, s:p.cterm00, "")
call <sid>hi("DiffRemoved",  s:p.gui08, s:p.gui00,  s:p.cterm08, s:p.cterm00, "")
call <sid>hi("DiffText",     s:p.gui0D, s:p.gui01,  s:p.cterm0D, s:p.cterm01, "")

" Git highlighting
call <sid>hi("gitCommitOverflow",  s:p.gui08, "", s:p.cterm08, "", "")
call <sid>hi("gitCommitSummary",   s:p.gui0B, "", s:p.cterm0B, "", "")

" GitGutter highlighting
call <sid>hi("GitGutterAdd",     s:p.gui0B, s:p.gui01, s:p.cterm0B, 234, "")
call <sid>hi("GitGutterChangeDelete",  s:p.gui0E, s:p.gui01, s:p.cterm0E, 234, "")
call <sid>hi("GitGutterChange",  s:p.gui0D, s:p.gui01, s:p.cterm0D, 234, "")
call <sid>hi("GitGutterDelete",  s:p.gui08, s:p.gui01, s:p.cterm08, 234, "")

" HTML highlighting
call <sid>hi("htmlBold",    s:p.gui0A, "", s:p.cterm0A, "", "")
call <sid>hi("htmlEndTag",  s:p.gui05, "", s:p.cterm05, "", "")
call <sid>hi("htmlItalic",  s:p.gui0E, "", s:p.cterm0E, "", "")
call <sid>hi("htmlTag",     s:p.gui05, "", s:p.cterm05, "", "")

" JavaScript highlighting
call <sid>hi("javaScriptBraces",  s:p.gui05, "", s:p.cterm05, "", "")
call <sid>hi("javaScriptNumber",  s:p.gui09, "", s:p.cterm09, "", "")
call <sid>hi("javaScript",        s:p.gui05, "", s:p.cterm05, "", "")

" Markdown highlighting
call <sid>hi("markdownCodeBlock",         s:p.gui0B, "", s:p.cterm0B, "", "")
call <sid>hi("markdownCode",              s:p.gui0B, "", s:p.cterm0B, "", "")
call <sid>hi("markdownError",             s:p.gui05, s:p.gui00, s:p.cterm05, s:p.cterm00, "")
call <sid>hi("markdownHeadingDelimiter",  s:p.gui0D, "", s:p.cterm0D, "", "")

" NERDTree highlighting
call <sid>hi("NERDTreeDirSlash",  s:p.gui0D, "", s:p.cterm0D, "", "")
call <sid>hi("NERDTreeExecFile",  s:p.gui05, "", s:p.cterm05, "", "")

" PHP highlighting
call <sid>hi("phpComparison",      s:p.gui05, "", s:p.cterm05, "", "")
call <sid>hi("phpMemberSelector",  s:p.gui05, "", s:p.cterm05, "", "")
call <sid>hi("phpParent",          s:p.gui05, "", s:p.cterm05, "", "")

" Python highlighting
call <sid>hi("pythonOperator",  s:p.gui0E, "", s:p.cterm0E, "", "")
call <sid>hi("pythonRepeat",    s:p.gui0E, "", s:p.cterm0E, "", "")

" Ruby highlighting
call <sid>hi("rubyAttribute",               s:p.gui0D, "", s:p.cterm0D, "", "")
call <sid>hi("rubyConstant",                s:p.gui0A, "", s:p.cterm0A, "", "")
call <sid>hi("rubyInterpolationDelimiter",  s:p.gui0F, "", s:p.cterm0F, "", "")
call <sid>hi("rubyInterpolation",           s:p.gui0B, "", s:p.cterm0B, "", "")
call <sid>hi("rubyRegexp",                  s:p.gui0C, "", s:p.cterm0C, "", "")
call <sid>hi("rubyStringDelimiter",         s:p.gui0B, "", s:p.cterm0B, "", "")
call <sid>hi("rubySymbol",                  s:p.gui0B, "", s:p.cterm0B, "", "")

" SASS highlighting
call <sid>hi("sassClassChar",  s:p.gui09, "", s:p.cterm09, "", "")
call <sid>hi("sassidChar",     s:p.gui08, "", s:p.cterm08, "", "")
call <sid>hi("sassInclude",    s:p.gui0E, "", s:p.cterm0E, "", "")
call <sid>hi("sassMixing",     s:p.gui0E, "", s:p.cterm0E, "", "")
call <sid>hi("sassMixinName",  s:p.gui0D, "", s:p.cterm0D, "", "")

" Signify highlighting
call <sid>hi("SignifySignAdd",     s:p.gui0B, s:p.gui01, s:p.cterm0B, s:p.cterm01, "")
call <sid>hi("SignifySignChange",  s:p.gui0D, s:p.gui01, s:p.cterm0D, s:p.cterm01, "")
call <sid>hi("SignifySignDelete",  s:p.gui08, s:p.gui01, s:p.cterm08, s:p.cterm01, "")

" Spelling highlighting
call <sid>hi("SpellBad",     "", s:p.gui00, "", "none", "undercurl")
call <sid>hi("SpellCap",     "", s:p.gui00, "", "none", "undercurl")
call <sid>hi("SpellLocal",   "", s:p.gui00, "", "none", "undercurl")
call <sid>hi("SpellRare",    "", s:p.gui00, "", "none", "undercurl")

set background=dark
