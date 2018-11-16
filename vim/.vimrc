" remove vi compatibility
set nocompatible

" syntax highlighting and colouring
syntax on

" tabs the way I want them
set tabstop=2
set softtabstop=2
set expandtab
set shiftwidth=2

" not sure if this works (adjust indentation properties as needed)
filetype plugin indent on

" not sure if this works (folds code?)
set foldenable

" informational
set number
set showcmd

" current line
set cursorline
:hi CursorLine cterm=NONE ctermbg=black

" plugins
call plug#begin('~/.vim/plugged')
Plug '~/.vim/vimplugs/git-blame.vim'
call plug#end()

" tabbing
nnoremap <C-Left> :tabprevious<CR>                                                                    
nnoremap <C-Right> :tabnext<CR>
nnoremap <C-n> :tabe %:h<CR>

