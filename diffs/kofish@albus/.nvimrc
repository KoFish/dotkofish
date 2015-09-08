--- /home/kofish/Sources/userconfsh/repos/kofish/home/.nvimrc	2015-09-08 16:18:10.768619869 +0200
+++ /home/kofish/.nvimrc	2015-09-08 16:19:06.562521115 +0200
@@ -46,10 +46,10 @@
 
 vnoremap // y/<C-R>"<CR>
 
-set textwidth=80
+set textwidth=100
 
 set backupdir=./.backup,~/.nvim/backup,/tmp
-set directory=./.swap,~/.nvim/swap,/tmp
+set directory=./.backup,~/.nvim/swap,/tmp
 
 "" Setup vim-plug
 
@@ -115,12 +115,9 @@
 Plug 'vim-erlang/vim-erlang-omnicomplete'
 Plug 'vim-erlang/erlang-motions.vim'
 
-"Plug 'ppikula/vim-wrangler'
+Plug 'ppikula/vim-wrangler'
 
 Plug 'Lokaltog/vim-distinguished'
-
-"Plug 'tomasr/molokai'
-
 "Plug 'erezsh/erezvim'
 "colorscheme erez
 "Plug 'jdkanani/vim-material-theme'
@@ -135,9 +132,8 @@
 
 call plug#end()
 
-let g:rehash256 = 1
-colorscheme molokai
-"colorscheme distinguished
+"colorscheme monochrome
+colorscheme distinguished
 
 """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
 
@@ -217,15 +213,15 @@
   autocmd FileType erlang let b:surround_60 = "<<\r>>"
 endif
 
-""" Setting vim-wrangler
-""""""""""""""""""""""""
-"
-"let g:erlangWranglerPath = '/usr/lib/erlang/lib/wrangler-1.1.01'
-"
-"autocmd FileType erlang vnoremap <leader>ee :WranglerExtractFunction<ENTER>
-"autocmd FileType erlang nnoremap <leader>em :WranglerRenameModule<ENTER>
-"autocmd FileType erlang nnoremap <leader>ef :WranglerRenameFunction<ENTER>
-"autocmd FileType erlang nnoremap <leader>ev :WranglerRenameVariable<ENTER>
-"autocmd FileType erlang nnoremap <leader>ep :WranglerRenameProcess<ENTER>
-"autocmd FileType erlang nnoremap <leader>emv :WranglerMoveFunction<ENTER>
-"autocmd FileType erlang nnoremap <leader>eu :WranglerUndo<ENTER>
+"" Setting vim-wrangler
+"""""""""""""""""""""""
+
+let g:erlangWranglerPath = '/usr/lib/erlang/lib/wrangler-1.1.01'
+
+autocmd FileType erlang vnoremap <leader>ee :WranglerExtractFunction<ENTER>
+autocmd FileType erlang nnoremap <leader>em :WranglerRenameModule<ENTER>
+autocmd FileType erlang nnoremap <leader>ef :WranglerRenameFunction<ENTER>
+autocmd FileType erlang nnoremap <leader>ev :WranglerRenameVariable<ENTER>
+autocmd FileType erlang nnoremap <leader>ep :WranglerRenameProcess<ENTER>
+autocmd FileType erlang nnoremap <leader>emv :WranglerMoveFunction<ENTER>
+autocmd FileType erlang nnoremap <leader>eu :WranglerUndo<ENTER>
