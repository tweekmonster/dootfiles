setlocal formatoptions+=cr noexpandtab
setlocal textwidth=80

if !exists('s:gopath')
  let s:gopath = expand('$GOPATH')
endif

if filewritable('.gofork') == 2
  let s:gofork = fnamemodify('.gofork', ':p')
  let $GOPATH = s:gofork.'base:'.s:gofork.'vendor'.(!empty(s:gopath) ? ':' . s:gopath : '')
endif
