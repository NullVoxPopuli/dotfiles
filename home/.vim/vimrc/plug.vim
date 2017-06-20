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
Plug 'airblade/vim-gitgutter'  " Git Info in the gutter
Plug 'vim-airline/vim-airline' " Status Line on the bottom of buffers
" Requires custom font... :-(
" Plug 'ryanoasis/vim-devicons'  " File Icons

" Syntaxes
Plug 'mustache/vim-mustache-handlebars', { 'for': ['html.handlebars'] }
Plug 'yalesov/vim-emblem'
Plug 'digitaltoad/vim-pug'
Plug 'pangloss/vim-javascript'   " Better than default js highlighting
Plug 'othree/es.next.syntax.vim' " ES6/7/Next
Plug 'mxw/vim-jsx'               " JSX

""""""""""""
" Behavior
Plug 'tpope/vim-surround'
Plug 'w0rp/ale'                 " async linting
Plug 'tpope/vim-fugitive'       " Git tools (blame)
Plug 'maralla/completor.vim', { 'for': ['javascript'] }    " Auto-Complete

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

"""""""""""""""""
" Auto Complete
let g:completor_node_binary = '/home/lprestonsegoiii/.nvm/versions/node/v8.1.2/bin/node'
let g:completor_auto_trigger = 0

""""""""""""""""""""""""""""""""""""""
" Vim Better Whitespace Configuration
"""""""""""""""""""""""""""""""""""""
autocmd BufWritePre * StripWhitespace

"""""""""
" ripgrep
"""""""""
let fzf_exclude=$FZF_EXCLUDE
let fzf_exclude_arg="-g \"!{". fzf_exclude . "}/*\""
let fzf_config="--column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --color \"always\""

let g:rg_command = "rg " . fzf_config . " " . fzf_exclude_arg

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
let g:NERDCreateDefaultMappings = 0  " No Defaults, define everything in keymap.vim

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Allow commenting and inverting empty lines (useful when commenting a
" region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
