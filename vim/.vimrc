" remove vi compatibility
set nocompatible

" syntax highlighting and colouring
syntax on

" indentation without hard tabs ... making actual tabs less than 8 (tabstop)
set tabstop=4
set softtabstop=2
set shiftwidth=2

" immediately expand tabs to use spaces
set expandtab

" disable folding
set foldenable

" show current line number
set number

" alwas show command line
set showcmd

" highlighting current line
set cursorline
:hi CursorLine cterm=NONE ctermbg=black

" ctrl+l opens a new tab in explore
nnoremap <C-l> :tabe %:h<CR>

" ctrl+k uses current tab to explore
nnoremap <C-k> :ex %:h<CR>

" Capital 'W' command now writes in root mode
command W :execute ':silent w !sudo tee % >/dev/null' | :edit!
