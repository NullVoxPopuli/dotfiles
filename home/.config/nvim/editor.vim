"""""""""""""""""""""""""
" Editor
"""""""""""""""""""""""""
syntax on
set encoding=utf-8
set guifont=DejaVu\ Sans\ Mono\ Nerd\ Font\ Complete

set cmdheight=1      " under statusline messages

set mouse=a          " use mouse for everything
set showmode         " show the current mode (Insert, Visual...)
set laststatus=2     " Always display status line

set cursorline       " highlight current line
set cursorcolumn     " highlight the current columnm

set ruler            " show current position

set number           " line numbers
" Because I use `s` for fast motion, this isn't useful to me anymore
" set relativenumber   " relative line numbers

set backspace=indent,eol,start  " backspace everywhere

set autoindent   " Use current indentation level for new lines
" set smartindent  " Try to guess indentation based on previous line

" Default indentation - editorconfig should override these
set tabstop=2
set shiftwidth=2
set expandtab
set linebreak " breaks lines on words instead of in the middle of a word
set breakindent " wrapping of lines is indented
let &showbreak='⇢ ' " the wrapped part of a line is indented a bit



" turn off smart indentation when pasting
" set pastetoggle=<F2>

set hlsearch  " highlight search terms
set list      " show whitespace

" set whitespace chars - everything
" set listchars=eol:¬,tab:>·,extends:>,precedes:<,space:·
" set whitespace chars - minimal
set listchars=eol:¬,extends:>,precedes:<,tab:\ \ 

set autoread   " Autoload reload files when they have changed on the disk

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Scrolling
set scrolloff=3  " minimum lines to keep above and below cursor

" Backup and Temp
silent !mkdir ~/.local/share/nvim/_backup/ > /dev/null 2>&1
silent !mkdir ~/.local/share/nvim/_temp/ > /dev/null 2>&1
silent !mkdir ~/.local/share/nvim/_undo/ > /dev/null 2>&1
silent !mkdir ~/.local/share/nvim/spell/ > /dev/null 2>&1

set backupdir=~/.local/share/nvim/_backup/    " where to put backup files.
set directory=~/.local/share/nvim/_temp/      " where to put swap files.
" Disable swap as it has never been useful to me
set noswapfile

" allow undo history to persist after closing buffer
if has('persistent_undo')
  set undodir=~/.local/share/nvim/_undo
  set undofile
end

""""""""""""""
" Spell Checker
""""""""""""""
set spellfile=~/.local/share/nvim/spell/en_us.utf-8.add


""""""""""""""""""""
" Panes / Buffers
""""""""""""""""""""
set splitright
set equalalways noequalalways " prevents splits from all auto-adjusting horizontally when one closes


""""""""""""""""""""
" Code Management
""""""""""""""""""""
set signcolumn=number    "" make better use of space by putting signs on top of the number in the signcolumn 

"" set the title of the window to the filename
set title
set titlestring=%f%(\ [%M]%)



"""""""""""""""""""""""""
" Other global UI tweaks 
"""""""""""""""""""""""""
" Global statusline
" The winbar is then used for the file name / path
set laststatus=3 
