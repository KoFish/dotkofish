let mapleader = ","

imap jk <ESC>

nnoremap <Leader>bn :bnext<CR>
nnoremap <Leader>bp :bprevious<CR>
nnoremap <Leader>bd :bdelete<CR>

nnoremap <Leader>tc :tabnew<CR>
nnoremap <Leader>tn :tabnext<CR>
nnoremap <Leader>tp :tabprevious<CR>
nnoremap <Leader>td :tabclose<CR>

set colorcolumn=+0
set textwidth=80

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

Plug 'tpope/vim-fugitive'
" :Git  - git command
" :Git! - Capture output to temporary file and edit it
" :Gstatus
" :Gcommit
" :Gpull
" :Gpush
" :Gdiff
" :Gblame

Plug 'tpope/vim-sensible'

Plug 'tpope/vim-surround'
" ds - Remove surrounding characters
" cs - Change surrounding characters to something else
" ys - Add surrounding characters

Plug 'tpope/vim-repeat'

Plug 'tpope/vim-sleuth'

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

Plug 'jimenezrick/vimerl'

Plug 'tomasr/molokai'

call plug#end()

let g:rehash256 = 1
colorscheme molokai

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"" Setting for undotree
"""""""""""""""""""""""

if has("persistent_undo")
    set undodir='~/.undodir/'
    set undofile
endif


"" Setting for nerdtree (and nerdtree-tabs)
"""""""""""""""""""""""""""""""""""""""""""

map <Leader>n <plug>NERDTreeTabsToggle<CR>

"" Setting for airline
""""""""""""""""""""""

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_left_sep = ' '
let g:airline_right_sep = ' '

"" Setting for CtrlP
""""""""""""""""""""

let g:ctrlp_cmd = 'CtrlPMRU'
let g:ctrlp_by_filename = 1
let g:ctrlp_switch_buffer = 'Et'
let g:ctrlp_max_depth = 3
let g:ctrlp_open_new_file = 'r'
let g:ctrlp_mruf_relative = 1

"" Setting for easymotion
"""""""""""""""""""""""""

let g:EasyMotion_smartcase = 1

"" Setting for undotree
"""""""""""""""""""""""

nmap <Leader>u :UndotreeToggle<CR>
