set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

"""""""""
" General
"""""""""
" Themes
Plugin 'tyrannicaltoucan/vim-deep-space'
Plugin 'dracula/vim'
Plugin 'rakr/vim-one'

" Git Commands from Vim
Plugin 'tpope/vim-fugitive'
Plugin 'vim-airline/vim-airline'

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

" Commenting
Plugin 'scrooloose/nerdcommenter'

" Syntax Checking
Plugin 'scrooloose/syntastic'

" Auto-complete
Plugin 'Valloric/YouCompleteMe'

""""""
" Ruby
""""""
Bundle 'vim-ruby/vim-ruby'
Plugin 'slim-template/vim-slim.git'
Plugin 'tpope/vim-rake'
Plugin 'tpope/vim-rails'

""""""""""""
" Javascript
""""""""""""
Plugin 'pangloss/vim-javascript'

"React
Plugin 'mxw/vim-jsx'

"Ember
Plugin 'dsawardekar/ember.vim'
Plugin 'nono/vim-handlebars'
Plugin 'yalesov/vim-emblem'

"""""""
" Other
"""""""
Plugin 'elzr/vim-json'
Bundle 'gabrielelana/vim-markdown'
" Vim (Hard Mode) - Forces better Navigation
" let g:hardtime_default_on = 1
Bundle 'takac/vim-hardtime'


call vundle#end()
