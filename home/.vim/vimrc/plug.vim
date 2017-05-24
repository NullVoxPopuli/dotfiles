call plug#begin('~/.vim/plugged')

"""""""""""""
" Code Style
Plug 'junegunn/vim-easy-align'
Plug 'scrooloose/nerdcommenter'
Plug 'ntpeters/vim-better-whitespace'

"""""""""""""""""
" File Navigation
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'ctrlpvim/ctrlp.vim'

""""""""""""
" Appearance
"Plug 'Yggdroot/indentLine'

" Syntaxes
Plug 'mustache/vim-mustache-handlebars', { 'for': ['html.handlebars'] }
"Plug 'joukevandermaas/vim-ember-hbs', { 'for': ['html.handlebars'] }

" Sensible Configuration
" https://github.com/tpope/vim-sensible#features
Plug 'tpope/vim-sensible'


call plug#end()
