" Plugins
call plug#begin('~/.local/share/nvim/plugged')
  " Syntax / Theme
  Plug 'https://github.com/joshdick/onedark.vim.git'

  " Editor
  Plug 'https://github.com/editorconfig/editorconfig-vim.git'

  " Syntax Support
  Plug 'https://github.com/joukevandermaas/vim-ember-hbs.git'
  Plug 'https://github.com/leafgarland/typescript-vim.git'

  " Helpin with VIM
  Plug 'https://github.com/takac/vim-hardtime.git'
  let g:list_of_insert_keys = []
  let g:hardtime_timeout = 1500
  let g:hardtime_showmsg = 1

call plug#end()


" True Colors (tm)
set termguicolors

"""""""""""""""""""""""""
" UI / Aesthetics
"""""""""""""""""""""""""
set background=dark
colorscheme onedark
let g:ariline_theme='onedark'

"""""""""""""""""""""""""
" Editor
"""""""""""""""""""""""""
syntax on
set encoding=utf-8

set mouse=a          " use mouse for everything
set showmode         " show the current mode (Insert, Visual...)
set laststatus=2     " Always display status line

set cursorline       " highlight current line
set cursorcolumn     " highlight the current columnm

set ruler            " show current position

set number           " line numbers
set relativenumber   " relative line numbers

set backspace=indent,eol,start  " backspace everywhere

set autoindent   " Use current indentation level for new linens
set smartindent  " Try to guess indentation based on previous line

" turn off smart indentation when pasting
" set pastetoggle=<F2>

set hlsearch  " highlight search terms
set list      " show whitespace

" set whitespace chars
set listchars=eol:¬,tab:>·,extends:>,precedes:<,space:·

set autoread   " Autoload reload files when they have changed on the disk

" Scrolling
set scrolloff=9  " minimum lines to keep above and below cursor

" Backup and Temp
set backupdir=~/.vim/_backup/    " where to put backup files.
set directory=~/.vim/_temp/      " where to put swap files.

" allow undo history to persist after closing buffer
if has('persistent_undo')
  set undodir=~/.vim/_undo
  set undofile
end

""""""""""""""""""""
" Panes / Buffers
""""""""""""""""""""
set splitright


""""""""""""""""""""
" Code Management
""""""""""""""""""""
set foldmethod=indent " fold based on indentation
set foldlevel=99
set nofoldenable      " don't open a file with folds, display the whole thing


" set the title of the window to the filename
set title
set titlestring=%f%(\ [%M]%)




"""""""""""""""""""""""""""""""
" Finally, load the keymap....
"""""""""""""""""""""""""""""""
so ~/.config/nvim/keymap.vim
