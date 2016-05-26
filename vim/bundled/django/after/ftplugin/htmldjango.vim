" Ensure UltiSnipsEdit opens the htmldjango.snippets file
call UltiSnips#FileTypeChanged()

" Add HTML snippets
UltiSnipsAddFiletypes html


if exists("loaded_matchit")
  let b:match_ignorecase = 1
  let b:match_skip = 's:Comment'
  let b:match_words = '<:>,' .
        \ '<\@<=[ou]l\>[^>]*\%(>\|$\):<\@<=li\>:<\@<=/[ou]l>,' .
        \ '<\@<=dl\>[^>]*\%(>\|$\):<\@<=d[td]\>:<\@<=/dl>,' .
        \ '<\@<=\([^/][^ \t>]*\)[^>]*\%(>\|$\):<\@<=/\1>,'  .
        \ '{% *if .*%}:{% *else *%}:{% *endif *%},' .
        \ '{% *ifequal .*%}:{% *else *%}:{% *endifequal *%},' .
        \ '{% *ifnotequal .*%}:{% *else *%}:{% *endifnotequal *%},' .
        \ '{% *ifchanged .*%}:{% *else *%}:{% *endifchanged *%},' .
        \ '{% *for .*%}:{% *endfor *%},' .
        \ '{% *with .*%}:{% *endwith *%},' .
        \ '{% *comment .*%}:{% *endcomment *%},' .
        \ '{% *block .*%}:{% *endblock *%},' .
        \ '{% *filter .*%}:{% *endfilter *%},' .
        \ '{% *spaceless .*%}:{% *endspaceless *%}'
endif


function! s:update_tags() abort
  let cmd = 'sed -n ''s/.*{% end\([a-zA-Z]\+\).*/\1/p'' '''.expand('%').''''
  let b:blocktags = uniq(sort(systemlist(cmd)))
endfunction


augroup vimrc_django
  autocmd!
  autocmd BufWritePost <buffer> call <sid>update_tags()
augroup END

call s:update_tags()
