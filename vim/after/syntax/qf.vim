syntax match qfFileName "[^|]*" contained nextgroup=qfSeparator
syntax match qfHiddenPath '^\%(\f\+/\)*' conceal nextgroup=qfFileName
if &l:conceallevel == 0
  setlocal conceallevel=1
endif
