let mapleader = "\<Space>"
set number
set relativenumber
inoremap kj <Esc>
cnoremap kj <Esc>
nnoremap tn :tabnew<Space>
nnoremap tk :tabnext<CR>
nnoremap tj :tabprev<CR>
nnoremap th :tabfirst<CR>
nnoremap tl :tablast<CR>


inoremap <C-k> <Esc>O<Esc>jA
nnoremap <leader>rv :source $HOME/.vimrc<Return>

call plug#begin()
Plug 'preservim/nerdtree'
call plug#end()

nnoremap  nt :NERDTreeToggle<CR>
nnoremap <C-b> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
nnoremap <C-n> :NERDTreeFocus<CR>
