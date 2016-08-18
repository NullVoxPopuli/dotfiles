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

" Multiple Cursor Selection
Plugin 'terryma/vim-multiple-cursors'

" Fuzzy File Finder
Plugin 'kien/ctrlp.vim'
" White space highlighter
Plugin 'ntpeters/vim-better-whitespace'

" Showing of leading whitespace and indentation
Plugin 'Yggdroot/indentLine'

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
" http://vim.wikia.com/wiki/Mapping_keys_in_Vim_-_Tutorial_(Part_1)
" <S-...> Shift
" <C-...> Control
" <M-...> Alt
" <A-...> Alt
" <D-...> command (moc only) super?


" Use Single quote for the <leader> key, cause it's closer than the default
" back slash
let mapleader = "'"

" Nerd Tree-Specfic Window Management
nmap <C-c> <plug>NERDTreeMapOpenVSplit <CR>
nmap <leader>nt <plug>NERDTreeTabsToggle<CR>
nmap <leader>nn :NERDTreeToggle <CR>
" s - splits to the right
" o - splits below

map <S-i> :vertical resize +10<CR>
map <C-<S-i>> :vertical resize +2<CR>
map <S-F6> :resize -10<CR>
map <S-F7> :resize +10<CR>
map <F6> :resize -2<CR>
map <F7> :resize +2<CR>
map <S-F8> :vertical resize -10<CR>
map <F8> :vertical resize -2<CR>

" Notes for myself, because holy cow, there are a lot of shortcuts
" gt - switch tabs
" <C-w w> switch panes (randomly?)
"

" Live Moving (Up and Down)
" Set to control (<C-k> : up, <C-j> : down)
let g:move_key_modifier = 'C'
vmap <C-<Up>> <Plug>MoveBlockUp
vmap <C-<Down>> <Plug>MoveBlockDown

"""""""""""""
" Navigation
"""""""""""""
" Exit insert mode upon arrow key navigation
inoremap <silent> <Up> <ESC><Up>
inoremap <silent> <Down> <ESC><Down>



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

"""""""""""""""""""""""""""""""""""
" Yggdroot/indentLine Configuration
"""""""""""""""""""""""""""""""""""
let g:indentLine_char = '│'
let g:indentLine_enabled = 1
let g:indentLine_color_term = 240
let g:indentLine_leadingSpaceEnabled = 1
let g:indentLine_leadingSpaceChar = '·'
" Set the displayed characters for indentation
" The normal vim way doesn't work for some reason
"set listchars=tab:·\i,trail:·
"set list


"""""""""""""""""""""""""
" Nerd Tree Configuration
""""""""""""""""""""""""""
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
