" Highlight variable blocks within html attributes

syntax cluster djangoBlocks add=djangoVarBlock2
syntax region djangoVarBlock2 start="{{" end="}}" contains=djangoFilter,djangoArgument,djangoVarError display containedin=htmlString

highlight default link djangoVarBlock2 djangoVarBlock
