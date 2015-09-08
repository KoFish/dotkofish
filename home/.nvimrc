" Note: Skip initialization for vim-tiny or vim-small.
if 0 | endif

let mapleader = ","

imap jk <ESC>
set listchars=eol:¬,tab:>-,trail:·,extends:>,precedes:<
set number
set smartcase
set colorcolumn=+0
set hidden

let g:python_host_skip_check = 1

if &t_Co > 2 || has("gui_running")
  syntax on
endif

filetype plugin indent on

set autoread

tnoremap <C-j><C-k> <C-\><C-n>
nnoremap <Leader>bn :bnext<CR>
nnoremap <Leader>bp :bprevious<CR>
nnoremap <Leader>bd :Bdelete<CR>
nnoremap <Leader>bb :buffers<CR>

nnoremap <Leader>tc :tabnew<CR>
nnoremap <Leader>tn :tabnext<CR>
nnoremap <Leader>tp :tabprevious<CR>
nnoremap <Leader>td :tabclose<CR>

nnoremap <Leader>. :set list!<CR>
nnoremap <Leader>, :nohlsearch<CR>
nnoremap <Leader>/ /<C-R><C-W><CR>

vnoremap // "0y/<C-R>0<CR>

nnoremap n nzz
nnoremap N Nzz
nnoremap <C-o> <C-o>zz
nnoremap <C-i> <C-i>zz

inoremap <C-O> <ESC>O

vnoremap // y/<C-R>"<CR>

set textwidth=80

set backupdir=./.backup,~/.nvim/backup,/tmp
set directory=./.swap,~/.nvim/swap,/tmp

"" Setup vim-plug

call plug#begin('~/.nvim/plugged')

Plug 'scrooloose/nerdcommenter'
" <Leader>cc  - Add comment level
" <Leader>ci  - Toggle comment
" <Leader>cu  - Uncomment
" <Leader>cm  - Add multipart delimiter comment
" <Leader>cs  - Add 'sexy' comments
" <Leader>cy  - Yank and comment

Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'

Plug 'tpope/vim-fugitive'  " git interface in vim
" :Git  - git command
" :Git! - Capture output to temporary file and edit it
" :Gstatus
" :Gcommit
" :Gpull
" :Gpush
" :Gdiff
" :Gblame

Plug 'tpope/vim-sensible'  " Sensible configuration

Plug 'tpope/vim-obsession' " Session management

Plug 'tpope/vim-sleuth'    " Automatic indentation detection

Plug 'tpope/vim-surround'  " Manipulate surround characters by (c)hange (s)urrounding (_) to (_)
" ds - Remove surrounding characters
" cs - Change surrounding characters to something else
" ys - Add surrounding characters

Plug 'tpope/vim-repeat'    " Allow more advanced repeat actions

Plug 'Lokaltog/vim-easymotion'
" <Leader><Leader><motion>

Plug 'kien/ctrlp.vim'
" ctrl-p and then ctrl-b to switch mode
" ctrl-r regexp search

Plug 'bling/vim-airline'

Plug 'mkitt/tabline.vim'

Plug 'mbbill/undotree'

Plug 'ervandew/supertab'

Plug 'airblade/vim-gitgutter'

"Plug 'jimenezrick/vimerl'

"Plug 'edkolev/erlang-motions.vim'

Plug 'vim-erlang/vim-erlang-runtime'
Plug 'vim-erlang/vim-erlang-compiler'
Plug 'vim-erlang/vim-erlang-omnicomplete'
Plug 'vim-erlang/erlang-motions.vim'

"Plug 'ppikula/vim-wrangler'

Plug 'Lokaltog/vim-distinguished'

"Plug 'tomasr/molokai'

"Plug 'erezsh/erezvim'
"colorscheme erez
"Plug 'jdkanani/vim-material-theme'
"colorscheme material-theme
"Plug 'fxn/vim-monochrome'
"Plug 'fholgado/minibufexpl.vim' " Buffer navigation

Plug 'rking/ag.vim'        " Using the_silver_searcher for searching in projects

Plug 'moll/vim-bbye'       " Delete buffers in a good way
" :Bdelete - Deletes buffer without killing vim

call plug#end()

let g:rehash256 = 1
colorscheme molokai
"colorscheme distinguished

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"" Setting for undotree
"""""""""""""""""""""""

nnoremap <Leader>u :UndotreeToggle<CR>

if has("persistent_undo")
    set undodir='~/.nvim/undodir/'
    set undofile
endif

"" Setting for nerdtree (and nerdtree-tabs)
"""""""""""""""""""""""""""""""""""""""""""

nnoremap <Leader>n :NERDTreeTabsToggle<CR>
nnoremap <Leader>Nc :NERDTreeCWD<CR>
nnoremap <Leader>Nf :NERDTreeFind<CR>

let NERDTreeRespectWildIgnore = 1
set wildignore+=*.beam

"" Setting for airline
""""""""""""""""""""""

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_left_sep = ' '
let g:airline_right_sep = ' '

"" Setting for CtrlP
""""""""""""""""""""

nnoremap <Leader>p :CtrlPMRU<CR>

let g:ctrlp_cmd = 'CtrlPMRU'
let g:ctrlp_by_filename = 1
let g:ctrlp_switch_buffer = 'Et'
let g:ctrlp_max_depth = 3
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = {
  \ 'file': '\v\.(beam)$',
  \ }
let g:ctrlp_max_files = 2000
let g:ctrlp_open_new_file = 'r'
let g:ctrlp_mruf_relative = 1

"" Setting for easymotion
"""""""""""""""""""""""""

let g:EasyMotion_smartcase = 1
let g:EasyMotion_startofline = 0 " keep cursor column when JK motion

"nmap / <Plug>(easymotion-sn)
"map n <Plug>(easymotion-next)
"map N <Plug>(easymotion-prev)

"" Setting for gitgutter
""""""""""""""""""""""""

let g:gitgutter_realtime = 1200

"" Setting vimerl
"""""""""""""""""""

let g:erlangHighlightBif = 1

if has("autocmd")
  augroup module
    autocmd BufRead,BufNewFile *.erl set expandtab
    autocmd BufRead,BufNewFile *.erl set tabstop=4
    autocmd BufRead,BufNewFile *.erl set shiftwidth=4
    autocmd BufRead,BufNewFile *.erl set textwidth=100
  augroup END
  autocmd FileType erlang let b:surround_60 = "<<\r>>"
endif

""" Setting vim-wrangler
""""""""""""""""""""""""
"
"let g:erlangWranglerPath = '/usr/lib/erlang/lib/wrangler-1.1.01'
"
"autocmd FileType erlang vnoremap <leader>ee :WranglerExtractFunction<ENTER>
"autocmd FileType erlang nnoremap <leader>em :WranglerRenameModule<ENTER>
"autocmd FileType erlang nnoremap <leader>ef :WranglerRenameFunction<ENTER>
"autocmd FileType erlang nnoremap <leader>ev :WranglerRenameVariable<ENTER>
"autocmd FileType erlang nnoremap <leader>ep :WranglerRenameProcess<ENTER>
"autocmd FileType erlang nnoremap <leader>emv :WranglerMoveFunction<ENTER>
"autocmd FileType erlang nnoremap <leader>eu :WranglerUndo<ENTER>
