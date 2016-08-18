"""""""""""""""""""""""""""""""""""""""""""
" UI Settings
"""""""""""""""""""""""""""""""""""""""""""
syntax on
set laststatus=2
set number						" Enables Line numbers
set t_Co=256					" 256 Terminal Colors

" Colors / Theme
set background=dark				" Dark mode
colorscheme deep-space
let g:rehash256 = 1

set ruler			" Always show current position

" The first setting tells vim to use "autoindent" (that is, use the current
" line's indent level to set the indent level of new lines). The second makes
" vim attempt to intelligently guess the indent level of any new line based
" on the previous line.
set autoindent
set smartindent

" turn off smart indentation when pasting
set pastetoggle=<F2>


set encoding=utf-8
set splitright
set foldmethod=indent
set foldlevel=99
" highlight the cursor line
set cursorline


set showmode "show the current mode (Insert, Visual...)
set mouse=a " use mouse for everything
" Doesn't work with mouse=a
" set mousemodel=popup " make a menu popup on right click


" set the title of the window to the filename
set title
set titlestring=%f%(\ [%M]%)

" highlight the terms
set hlsearch
