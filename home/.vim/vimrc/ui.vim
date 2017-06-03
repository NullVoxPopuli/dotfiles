"""""""""""""""""""""""""""""""""""""""""""
" UI Settings
"""""""""""""""""""""""""""""""""""""""""""
syntax on
set laststatus=2      " Always Displays the status line
set number						" Enables Line numbers
set relativenumber    " Relative Line Numbers - Useful for commands
set t_Co=256					" 256 Terminal Colors
set ruler		          " Always show current position

" Colors / Theme
set background=dark				" Dark mode
colorscheme onedark
let g:rehash256 = 1 " Makes the theme recalculate colors to fit in 256colorspace

set autoindent   " Use current indentation level for new linens
set smartindent  " Try to guess indentation based on previous line

" turn off smart indentation when pasting
set pastetoggle=<F2>

set encoding=utf-8
set splitright
set foldmethod=indent
set foldlevel=99

set cursorline " highlight the cursor line

set showmode "show the current mode (Insert, Visual...)
set mouse=a " use mouse for everything

" set the title of the window to the filename
set title
set titlestring=%f%(\ [%M]%)

" highlight the terms
set hlsearch


" Autoload reload files when they have changed on the disk
set autoread


"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif


set backupdir=~/.vim/_backup//    " where to put backup files.
set directory=~/.vim/_temp//      " where to put swap files.
