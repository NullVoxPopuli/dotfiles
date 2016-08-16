set nocompatible " Fixes old Vi bugs
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

"""""""""
" General
"""""""""
" Themes
Plugin 'tyrannicaltoucan/vim-deep-space'

" Git Commands from Vim
Plugin 'tpope/vim-fugitive'
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
" File / Project Browsing
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdtree-git-plugin'
Plugin 'jistr/vim-nerdtree-tabs'

" Allows moving lines / selections up or down
Bundle 'matze/vim-move'

" Fuzzy File Finder
Plugin 'kien/ctrlp.vim'
" White space highlighter
Plugin 'ntpeters/vim-better-whitespace'

""""""
" Ruby
""""""
Bundle 'vim-ruby/vim-ruby'
Plugin 'slim-template/vim-slim.git'
Plugin 'tpope/vim-rake'

""""""""""""
" Javascript
""""""""""""
Plugin 'pangloss/vim-javascript'

"React
Plugin 'mxw/vim-jsx'

"Ember
Plugin 'dsawardekar/ember.vim'
Plugin 'nono/vim-handlebars'

"""""""
" Other
"""""""
Plugin 'elzr/vim-json'
Bundle 'gabrielelana/vim-markdown'
" Vim (Hard Mode) - Forces better Navigation
" let g:hardtime_default_on = 1
Bundle 'takac/vim-hardtime'


call vundle#end()

filetype plugin indent on


"""""""""""""""""""""""""""""""""""""""""""
" Commands / Key Mappings
""""""""""""""""""""""""""""""""""""""""""
" <S-...> Shift
" <C-...> Control
" <M-...> Alt
" <A-...> Alt
" <D-...> command (moc only) super?


" Use Single quote for the <leader> key, cause it's closer than the default
" back slash
let mapleader = "'"

" Nerd Tree-Specfic Window Management
map <C-c> :NERDTreeMapOpenVSplit <CR>
:map <Leader>n <plug>NERDTreeTabsToggle<CR>
"	:map <S-F5> :vertical resize +10<CR>
"	:map <F5> :vertical resize +2<CR>
"	:map <S-F6> :resize -10<CR>
"	:map <S-F7> :resize +10<CR>
"	:map <F6> :resize -2<CR>
"	:map <F7> :resize +2<CR>
"	:map <S-F8> :vertical resize -10<CR>
"	:map <F8> :vertical resize -2<CR>

" Notes for myself, because holy cow, there are a lot of shortcuts
" gt - switch tabs
" <C-w w> switch panes (randomly?)
"

" Live Moving (Up and Down)
" Set to control (<C-k> : up, <C-j> : down)
let g:move_key_modifier = 'C'
vmap <C-<Up>> <Plug>MoveBlockUp
vmap <C-<Down>> <Plug>MoveBlockDown

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
set autoindent
set smartindent
set encoding=utf-8
set splitright
set foldmethod=indent
set foldlevel=99


set showmode "show the current mode (Insert, Visual...)
set mouse=a " use mouse for everything


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 2 spaces
set shiftwidth=2
set tabstop=2

"""""""""""""""""""""""""
" Nerd Tree Configuration
""""""""""""""""""""""""""
nmap <leader>nt :NERDTreeToggle <CR>
let NERDTreeShowHidden=1 " This also ignores .gitignore
let NERDTreeIgnore=['.git$[[dir]]', '.swp']

autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p

""""""""""""""""""""""""""""""""""""""
" Vim Better Whitespace Configuration
"""""""""""""""""""""""""""""""""""""
autocmd BufWritePre * StripWhitespace


" YouCompleteMe Space+G go-to-definition
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>


"""""""""""""
" Navigation
"""""""""""""
" Exit insert mode upon arrow key navigation
inoremap <silent> <Up> <ESC><Up>
inoremap <silent> <Down> <ESC><Down>


""""""""""""""""""""""
" Hacks n' Things
""""""""""""""""""""""
" https://github.com/matze/vim-move/issues/8
" Basically, the terminal intercepts the alt key, and vim only
" sees it as ESC -- not cool.
let c='a'
while c <= 'z'
  exec "set <A-".c.">=\e".c
  exec "imap \e".c." <A-".c.">"
  let c = nr2char(1+char2nr(c))
endw

set timeout ttimeoutlen=50
