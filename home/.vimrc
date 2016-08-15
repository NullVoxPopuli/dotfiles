set nocompatible " Fixes old Vi bugs
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

"""""""""
" General
"""""""""
" Git Commands from Vim
Plugin 'tpope/vim-fugitive'
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
" File / Project Browsing
Plugin 'scrooloose/nerdtree' 
Plugin 'scrooloose/nerdtree-git-plugin'
Plugin 'jistr/vim-nerdtree-tabs'
" Fuzzy File FInder
Plugin 'kien/ctrlp.vim'

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


" Typescript
" Plugin 'leafgarland/typescript-vim'

" Jade/Pug
" Plugin 'digitaltoad/vim-pug'

call vundle#end()

filetype plugin indent on

" Universal Settings
syntax on
set laststatus=2
set number						" Enables Line numbers
set t_Co=256					" 256 Terminal Colors
" let g:solarized_termcolors=256  " Force solarized to use 256 colors
set background=dark				" Dark mode

" colorscheme solarized 			" Use solarized font
colorscheme molokai
let g:molokai_original=1
let g:rehash256 = 1

set ruler						
set autoindent
set smartindent
set encoding=utf-8
set splitright
set foldmethod=indent
set foldlevel=99

" Highlight extra whitespaces as red
:highlight ExtraWhitespace ctermbg=red guibg=red
:match ExtraWhitespace /\s\+%/

" Python Exclusive Settings
au BufNewFile,BufRead *.py
	\ set tabstop=4 |
	\ set softtabstop=4 |
	\ set shiftwidth=4 |
	\ set expandtab |
	\ set fileformat=unix |

" Typescript and Javascript
au BufNewFile,BufRead *.ts,*.js,*.jade,*.scss,*.css,*.html
	\ set tabstop=2 |
	\ set softtabstop=2 |
	\ set shiftwidth=2 |

" YouCompleteMe Space+G go-to-definition
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>

" Python Highlighting
let python_highlight_all=1

let NERDTreeIgnore=['\.pyc$', '\~$', '__pycache__']
let g:typescript_indent_disable = 1

" Nerdtree configuration
augroup appearance
	au!
	let g:nerdtree_tabs_open_on_console_startup=1
	:map <Leader>n <plug>NERDTreeTabsToggle<CR>
	:map <S-F5> :vertical resize +10<CR>
	:map <F5> :vertical resize +2<CR>
	:map <S-F6> :resize -10<CR>
	:map <F6> :resize -2<CR>
	:map <S-F7> :resize +10<CR>
	:map <F7> :resize +2<CR>
	:map <S-F8> :vertical resize -10<CR>
	:map <F8> :vertical resize -2<CR>
augroup END
