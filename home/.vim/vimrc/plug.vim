call plug#begin('~/.vim/plugged')

"""""""""""""""""
" File Navigation
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeToggle' }

""""""""""""""""
" Fuzzy File Finding
" Installs fzf bin"
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

""""""""""""
" Appearance
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'

" Syntaxes
Plug 'mustache/vim-mustache-handlebars', { 'for': ['html.handlebars'] }

""""""""""""
" Behavior
Plug 'tpope/vim-surround'
Plug 'w0rp/ale' " async linting

"""""""""""""
" Code Style
Plug 'junegunn/vim-easy-align'
Plug 'scrooloose/nerdcommenter'
Plug 'ntpeters/vim-better-whitespace'



" Sensible Configuration
" https://github.com/tpope/vim-sensible#features
" TODO: what does this do, and do I still need it?
Plug 'tpope/vim-sensible'

call plug#end()

""""""""""""""""""""""""""""""
" |                        | "
" |  Plugin Configuration  | "
" |                        | "
""""""""""""""""""""""""""""""

""""""""""""""""""
" ALE Linting
let g:ale_sign_column_always = 1

""""""""""""""""""""""""""""""""""""""
" Vim Better Whitespace Configuration
"""""""""""""""""""""""""""""""""""""
autocmd BufWritePre * StripWhitespace

"""""""""
" ripgrep
"""""""""
let g:rg_command = '
  \ rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --color "always"
  \ -g "*.{js,json,php,md,styl,jade,html,config,py,cpp,c,go,hs,rb,conf}"
  \ -g "!{.git,node_modules,vendor}/*" '

command! -bang -nargs=* F call fzf#vim#grep(g:rg_command .shellescape(<q-args>), 1, <bang>0)


""""""""""""""
" vim-arline
""""""""""""""
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

""""""""""""""""
" NERDTree
""""""""""""""""
let NERDTreeShowHidden=1 " This also ignores .gitignore
let NERDTreeIgnore=['.git$[[dir]]', '.swp']
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p



"""""""""""""""""""""""""""
" scrooloose/nerdcommenter
""""""""""""""""""""""""""
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Allow commenting and inverting empty lines (useful when commenting a
" region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
