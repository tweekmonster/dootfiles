if exists('g:_did_vimrc_plugins')
  finish
endif

let g:_did_vimrc_plugins = 1

call plug#begin(g:_vimrc_plugins)

" Load bundled first
function! s:load_bundles() abort
  for dir in glob(g:_vimrc_base.'/bundled/*', 0, 1)
    if !isdirectory(dir)
      continue
    endif
    execute 'Plug '''.dir.''''
  endfor
endfunction

call s:load_bundles()

" Certain plugin developers are prolific enough to group their plugins
" together.  Some may require a specific order and grouping them makes it
" easier to deal with.

" Shougo
Plug 'Shougo/vimproc.vim', {'do': 'make'}
Plug 'Shougo/unite.vim'
Plug 'Shougo/vimfiler.vim'
if has('nvim')
  Plug 'Shougo/deoplete.nvim'
endif
Plug 'Shougo/echodoc.vim'
Plug 'Shougo/neco-vim'

" Shougo - Deoplete
if has('nvim')
  Plug 'carlitux/deoplete-ternjs'
  Plug 'zchee/deoplete-jedi'
endif

" junegunn
Plug 'junegunn/fzf', {'do': './install --bin'}
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vader.vim'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/vim-peekaboo'
Plug 'junegunn/gv.vim'

" tpope
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-scriptease'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-scriptease'

" My stuff
Plug 'tweekmonster/fzf-filemru'
Plug 'tweekmonster/braceless.vim'
Plug 'tweekmonster/sshclip', {'do': './bin/sshclip-client --impersonate sshclip'}

" Theming
Plug 'bling/vim-airline'
Plug 'ryanoasis/vim-devicons'
Plug 'ap/vim-buftabline'

" Project Related
Plug 'benekastah/neomake'
Plug 'gregsexton/gitv'
Plug 'airblade/vim-gitgutter'
Plug 'airblade/vim-rooter'
Plug 'editorconfig/editorconfig-vim'

" Snippets
Plug 'mattn/emmet-vim'
if v:version > 703
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'
endif

" Utilities
Plug 'FooSoft/vim-argwrap'
Plug 'Lokaltog/vim-easymotion'
Plug 'haya14busa/incsearch.vim'
Plug 'Raimondi/delimitMate'
Plug 'chrisbra/NrrwRgn'
Plug 'christoomey/vim-tmux-navigator'
Plug 'editorconfig/editorconfig-vim'
Plug 'edsono/vim-matchit'
Plug 'kana/vim-textobj-line'
Plug 'kana/vim-textobj-user'
Plug 'michaeljsmith/vim-indent-object'
Plug 'tomtom/tcomment_vim'
Plug 'vim-scripts/BufOnly.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'vim-scripts/BufOnly.vim'
Plug 'dhruvasagar/vim-table-mode'
Plug 'godlygeek/tabular'
Plug 'mhinz/vim-grepper'
Plug 'AndrewRadev/sideways.vim'

" Web Development
Plug 'fatih/vim-nginx'
Plug 'othree/xml.vim'
Plug 'othree/html5.vim'
Plug 'othree/yajs.vim'
Plug 'nono/jquery.vim'
Plug 'pangloss/vim-javascript'
Plug 'kchmck/vim-coffee-script'
Plug 'groenewege/vim-less'
Plug 'csscomb/vim-csscomb'
Plug 'posva/vim-vue'

" Misc File Types
Plug 'davidhalter/jedi-vim'
Plug 'hdima/python-syntax'
Plug 'tmux-plugins/vim-tmux'
Plug 'fatih/vim-go'
Plug 'elzr/vim-json'
Plug 'cespare/vim-toml'
Plug 'plasticboy/vim-markdown'
Plug 'ekalinin/Dockerfile.vim'
Plug 'JulesWang/css.vim'
Plug 'cakebaker/scss-syntax.vim'

" Scan for development replacements before plug#end()
call vimdev#scan()

call plug#end()
