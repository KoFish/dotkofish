"" Globals
set nocompatible
set backupdir=~/.backup,./.backup,.,/tmp
set directory=~/.backup,./.backup,.,/tmp
call pathogen#infect()
syntax enable
set number
set hidden
set encoding=utf-8
set showcmd
filetype plugin indent on
let mapleader=","

au vimenter * if !argc() | NERDTree | endif
nnoremap <leader>n :NERDTree<CR>

"nnoremap <leader>g :GundoToggle<CR>
"let g:gundo_close_on_revert = 1

let g:SuperTabCompletionContexts = ['s:ContextText', 's:ContextDiscover']
let g:SuperTabContextTextOmniPrecedence = ['&omnifunc', '&completefunc']
let g:SuperTabRetainCompletionDuration = 'session'
let g:SuperTabNoCompleteAfter = [',', '\s']
"let g:SuperTabLongestEnhanced = 1
"let g:SuperTabLongestHighlight = 1
set completeopt=menu,menuone,preview,longest

"" Whitespaces
set nowrap ai
set tabstop=4 shiftwidth=4
set expandtab
set backspace=indent,eol,start

"" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

"" Looks
let g:Powerline_symbols = 'fancy'
set background=dark
colorscheme camo
"colorscheme warm_grey
set guioptions=acf
set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 10
set guicursor=a:blinkon0,i-ci:ver25-Cursor,r-cr:hor50-Cursor
set cpoptions+=$
set laststatus=2
set statusline=%F%m%r%h%w[%{&ff}]%{fugitive#statusline()}\ %=%y[POS=%3l,%3v][%3p%%]
set scrolloff=10
set listchars=eol:$,tab:>-,trail:·,precedes:<,extends:>
set textwidth=0
set wrapmargin=2
set cc=+1
hi ColorColumn ctermbg=grey guibg=#3f3f3f guifg=#afafaf
hi Folded guifg=#707070 guibg=#1f1f1f
hi FoldColumn guifg=#707070 guibg=#1f1f1f
set foldcolumn=5

"" Useful keybindings
nnoremap <leader>o i<CR><Esc>
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>
nnoremap <leader>as m':%!astyle<Enter>''
inoremap jk <Esc>
inoremap <Esc> <nop>
nnoremap <silent>,, :nohl<CR>
nnoremap <leader>. .`[
nnoremap ` :ShowMarksOnce<CR>`
nnoremap ' :ShowMarksOnce<CR>'
nnoremap <silent> <Space> @=(foldlevel('.')?'zA':"\<Space>")<CR>
nnoremap <silent> <S-Space> @=(foldlevel('.')?'za':"\<S-Space>")<CR>
vnoremap <Space> zf
nnoremap ts :tab split
nnoremap tc :tabclose
nnoremap to :tabonly

"" Useful autocommands
autocmd VimEnter * RainbowParenthesesToggle
"au Syntax * RainbowParenthesesLoadRound
autocmd QuickFixCmdPost *grep* cwindow

"" Language specific stuff

""" Lisp:

au FileType scheme setlocal lispwords+=define*,define-class,define-method,let-values,lambda*,match,catch,with-throw-handler,syntax-rules,receive,define-syntax
au FileType scheme setlocal lispwords-=if
au FileType scheme setlocal foldmethod=manual
