" Don't care about compatibility
set nocompatible
""""""""""""""""""""
" Plugins
""""""""""""""""""""
call plug#begin('~/.local/share/nvim/plugged')
  """""""""""""""""
  " Syntax / Theme
  Plug 'joshdick/onedark.vim'

  """""""""""""""""
  " Editor
  """""""""""""""""
  Plug 'ntpeters/vim-better-whitespace'
  autocmd BufWritePre * StripWhitespace

  " Finding
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'scrooloose/nerdtree'
  Plug 'Xuyuanp/nerdtree-git-plugin'

  let NERDTreeShowHidden=0 " This also ignores .gitignore
  let NERDTreeIgnore=['.git$[[dir]]', '.swp', 'dist', 'tmp', 'node_modules', 'obj', 'bin', 'bower_components']
  let NERDTreeAutoDeleteBuffer = 1
  let NERDTreeMinimalUI = 1
  let NERDTreeDirArrows = 1

  " Working with code


  Plug 'jiangmiao/auto-pairs'
  let g:AutoPairsFlyMode = 1
  " M-b jumps back
  let g:AutoPairsShortcutJump = ''
  let g:AutoPairsShortcutFastWrap = ''



  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-commentary'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'w0rp/ale'
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  let g:deoplete#enable_at_startup = 1
  " Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }



  """"""""""""""""""
  " Status
  Plug 'airblade/vim-gitgutter'
  Plug 'vim-airline/vim-airline'
  let g:airline_powerline_fonts = 1

  if !exists('g:airline_symbols')
    let g:airline_symbols = {}
  endif
  let g:airline_symbols.space = "\ua0"
  let g:airline#extensions#tabline#enabled = 1

  """""""""""""""""""""
  " Syntax Support
  Plug 'OmniSharp/omnisharp-vim'
  let g:OmniSharp_server_path = '/home/lprestonsegoiii/Applications/omnisharp-x64/run'
  let g:OmniSharp_server_type = 'roslyn'
  let g:OmniSharp_timeout = 5


  Plug 'joukevandermaas/vim-ember-hbs'
  Plug 'mhartington/nvim-typescript', { 'do': './install.sh' }
  Plug 'HerringtonDarkholme/yats.vim'
  Plug 'mxw/vim-jsx'
  let g:jsx_ext_required = 1

  """"""""""""""""""""""
  " Helpin with VIM
  Plug 'takac/vim-hardtime'
  let g:list_of_insert_keys = []
  let g:hardtime_timeout = 1500
  let g:hardtime_showmsg = 1

call plug#end()

""""""""""""""""""""""""""""""""
"
" End plugin config
"
" ------------------------------
"
" Begin editor settings
"
""""""""""""""""""""""""""""""""


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
set guifont=DejaVu\ Sans\ Mono

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
set equalalways noequalalways " prevents splits from all auto-adjusting horizontally when one closes


""""""""""""""""""""
" Code Management
""""""""""""""""""""
set foldmethod=indent " fold based on indentation
set foldlevel=99
set nofoldenable      " don't open a file with folds, display the whole thing


" set the title of the window to the filename
set title
set titlestring=%f%(\ [%M]%)


:function TabsToSpaces()
:  set tabstop=2 shiftwidth=2 expandtab
:  retab
:endfunction


"""""""""""""""""""""""""""""""
" Finally, load the keymap....
"""""""""""""""""""""""""""""""
so ~/.config/nvim/keymap.vim
so ~/.config/nvim/oni-config.vim
