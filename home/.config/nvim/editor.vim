" True Colors (tm)
set termguicolors

"""""""""""""""""""""""""
" UI / Aesthetics
"""""""""""""""""""""""""
set background=dark
colorscheme onedark
let g:airline_theme='onedark'

"""""""""""""""""""""""""
" Editor
"""""""""""""""""""""""""
syntax on
set encoding=utf-8
set guifont=DejaVu\ Sans\ Mono

set cmdheight=1      " under statusline messages

set mouse=a          " use mouse for everything
set showmode         " show the current mode (Insert, Visual...)
set laststatus=2     " Always display status line

set cursorline       " highlight current line
set cursorcolumn     " highlight the current columnm

set ruler            " show current position

set number           " line numbers
set relativenumber   " relative line numbers

set backspace=indent,eol,start  " backspace everywhere

set autoindent   " Use current indentation level for new lines
" set smartindent  " Try to guess indentation based on previous line

" Default indentation - editorconfig should override these
set tabstop=2
set shiftwidth=2
set expandtab

" turn off smart indentation when pasting
" set pastetoggle=<F2>

set hlsearch  " highlight search terms
set list      " show whitespace

" set whitespace chars
set listchars=eol:¬,tab:>·,extends:>,precedes:<,space:·

set autoread   " Autoload reload files when they have changed on the disk

" Scrolling
set scrolloff=3  " minimum lines to keep above and below cursor

" Backup and Temp
set backupdir=~/.local/share/nvim/_backup/    " where to put backup files.
set directory=~/.local/share/nvim/_temp/      " where to put swap files.

" allow undo history to persist after closing buffer
if has('persistent_undo')
  set undodir=~/.local/share/nvim/_undo
  set undofile
end

""""""""""""""""""""
" Panes / Buffers
""""""""""""""""""""
set splitright
set equalalways noequalalways " prevents splits from all auto-adjusting horizontally when one closes


""""""""""""""""""""
" Code Management
""""""""""""""""""""
set foldmethod=indent "" fold based on indentation
set foldlevel=99
set nofoldenable      "" don't open a file with folds, display the whole thing
set signcolumn=yes    "" always show the signcolumn

"" set the title of the window to the filename
set title
set titlestring=%f%(\ [%M]%)
