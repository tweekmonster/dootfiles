if exists('main_syntax')
  finish
endif
unlet b:current_syntax
syntax include @HTML $VIMRUNTIME/syntax/html.vim

" Vue template highlighting
syntax keyword htmlTagName slot contained

syntax keyword htmlVueFlowOps in of contained
syntax keyword htmlVueKeyword true false typeof null this instanceof contained

syntax match htmlVueIdentifier "\i\+" contained
syntax match htmlVueFunc "\i\+("me=e-1 contained
syntax match htmlVueNumber #-\?\d\+\%(\.\d\+\)\?# contained

syntax region htmlVueString start=#'# skip=#\\'# end=#'# contained
syntax region htmlVueObject start=#{# end=#}# contained contains=htmlVueString,htmlVueNumber,htmlVueIdentifier
syntax region htmlVueFuncArgs start=#(# end=#)# contained contains=htmlVueKeyword,htmlVueNumber,htmlVueIdentifier
syntax region htmlVueValue start=+"+ end=+"+ transparent contained contains=htmlVueObject,htmlVueFunc,htmlVueNumber,htmlVueFlowOps,htmlVueFuncArgs,htmlVueIdentifier

syntax match htmlVueArg '[^=]\+='he=e-1,me=e contained nextgroup=htmlVueValue
syntax match htmlVueAttr '\%(\%(v-[^=]\+\)\|\%(@\|:\)[^=]\+\)="[^"]\+"' transparent containedin=htmlTag contains=htmlVueArg

syntax region htmlTemplate start=+<script [^>]*type *=[^>]*text/template[^>]*>+
\                       end=+</script>+me=s-1 keepend
\                       contains=@HTML,htmlScriptTag,@htmlPreproc

highlight default link htmlVueArg Special
highlight default link htmlVueValue Special
highlight default link htmlVueTpl Special
highlight default link htmlVueIdentifier Identifier
highlight default link htmlVueFunc Function
highlight default link htmlVueFlowOps Repeat
highlight default link htmlVueKeyword Keyword
highlight default link htmlVueNumber Number
highlight default link htmlVueString String
