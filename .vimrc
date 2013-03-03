set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle
call vundle#rc()

Bundle 'gmarik/vundle'

Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-surround'
Bundle 'majutsushi/tagbar'
Bundle 'kien/ctrlp.vim'
Bundle 'kien/rainbow_parentheses.vim'
Bundle 'scrooloose/syntastic'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/nerdcommenter'
Bundle 'airblade/vim-gitgutter'
Bundle 'Lokaltog/vim-powerline'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'flazz/vim-colorschemes'
Bundle 'docunext/closetag.vim'
Bundle 'mbbill/undotree'
Bundle 'mileszs/ack.vim'
Bundle 'Shougo/neocomplcache'
Bundle 'jacquesbh/vim-showmarks'
Bundle 'jamessan/vim-gnupg'

syntax enable
filetype plugin indent on

set number
set hidden
set encoding=utf-8
set showcmd
set visualbell
let mapleader=","

set backupdir=~/.backup,./.backup,/tmp
set directory=~/.backup,./.backup,.,/tmp
set undodir=~/.vim/undo
set undofile

autocmd VimEnter * if !argc() | NERDTree | endif
nnoremap <leader>n :NERDTree<CR>

let g:EasyMotion_keys = 'abcdefghijklmnopqrstuvxyzABCDEFGHIJKLMNOPQRSTUVXYZ'
let g:EasyMotion_grouping = 1
let g:EasyMotion_leader_key = '<leader><leader>'

let g:ctrlp_cmd = "CtrlP"
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_switch_buffer = 'e'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.o,*.la,*.pyc,*.png,*.jpg

let g:ctrlp_custom_ignore = '\v\~$|\.(o|swp|pyc|wav|mp3|ogg|blend)$|(^|[/\\])\.(git|hg|svn)($|[/\\])'

let NERDTreeIgnore = ['\.pyc$', '\.pyo$', '^\.git$', '\.o$']

let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_underbar_completion = 1

let g:tagbar_compact = 1

inoremap <expr><CR> neocomplcache#smart_close_popup() . "\<CR>"
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"

autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
"autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

"" Whitspaces
set nowrap autoindent
set tabstop=4 shiftwidth=4
set expandtab
set backspace=indent,eol,start


"" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase


"" Look & Feel
set t_Co=256
colorscheme jellybeans
let g:Powerline_symbols = 'fancy'
set background=dark
set guioptions=acf
set guifont=Liberation\ Mono\ for\ Powerline
set guicursor=a:blinkon0,i-ci:ver25-Cursor,r-cr:hor50-Cursor
set cpoptions+=$
set laststatus=2
set statusline=%F%m%r%h%w[%{&ff}]%{fugitive#statusline()}\ %=%y[POS=%3l,%3v][%3p%%]
set listchars=eol:$,tab:>-,trail:·,precedes:<,extends:>
set colorcolumn=+1
set foldcolumn=5
set scrolloff=1
set sidescrolloff=5
set display=lastline
set autoread
set autowrite
hi ColorColumn ctermbg=grey guibg=#3f3f3f guifg=#afafaf
hi Folded ctermbg=black guifg=#707070 guibg=#1f1f1f
hi FoldColumn ctermbg=black guifg=#707070 guibg=#1f1f1f

"" Useful keybindings

""" Habit breakers
inoremap <Esc> <nop>
nnoremap hh <NOP>
nnoremap jj <NOP>
nnoremap kk <NOP>
nnoremap ll <NOP>
nnoremap <Up> <NOP>
nnoremap <Down> <NOP>
nnoremap <Left> <NOP>
nnoremap <Right> <NOP>

inoremap jk <Esc>
nmap j gj
nmap k gk
nmap <C-j> :bnext<CR>
nmap <C-k> :bprev<CR>
nnoremap Y y$
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>
nnoremap <silent>; :nohl<CR>
nnoremap <leader>. .`[
nnoremap ` :ShowMarksOnce<CR>`
nnoremap ' :ShowMarksOnce<CR>'
nnoremap <silent> <Space> @=(foldlevel('.')?'zA':"\<Space>")<CR>
nnoremap <silent> <S-Space> @=(foldlevel('.')?'za':"\<S-Space>")<CR>
vnoremap <Space> zf
nnoremap ts :tab split
nnoremap tc :tabclose
nnoremap to :tabonly

command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
nnoremap <leader>d :DiffOrig<CR>

nnoremap <F5> :UndotreeToggle<CR>
nnoremap <F4> :TagbarToggle<CR>

nmap <leader>w :setlocal wrap!<CR>:setlocal wrap?<CR>

"" Useful autocommands
autocmd VimEnter * RainbowParenthesesToggle
autocmd QuickFixCmdPost *grep* cwindow

let g:syntastic_python_checker_args='--ignore=E501'

let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }
