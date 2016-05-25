let s:pattern = '\(function\|if\|for\|while\|try\)\>'


function! s:bounds() abort
  let ind = max([0, indent(line('.')) - &l:sw])

  let head = search('^ \{'.ind.'}'.s:pattern, 'nbW')
  if !head
    return [0, 0]
  endif

  let found = matchstr(getline(head), s:pattern)
  let tail = search('^ \{'.ind.'}end'.found.'\>', 'nW')
  return [head, tail]
endfunction


function! s:inner() abort
  let [head, tail] = s:bounds()
  if head && tail
    execute 'keepjumps normal! '.(head + 1).'GV'.(tail - 1).'G'
  endif
endfunction


function! s:around() abort
  let [head, tail] = s:bounds()
  if head && tail
    execute 'keepjumps normal! '.head.'GV'.tail.'G'
  endif
endfunction


function! vim#blockobj#setup() abort
  vnoremap <buffer> iP :<c-u>call <sid>inner()<cr>
  vnoremap <buffer> aP :<c-u>call <sid>around()<cr>

  omap <buffer> iP :<c-u>normal ViP<cr>
  omap <buffer> aP :<c-u>normal VaP<cr>
endfunction
