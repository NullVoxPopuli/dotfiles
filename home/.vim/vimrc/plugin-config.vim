"""""""""""""""""""""""""
" Nerd Tree Configuration
""""""""""""""""""""""""""
let NERDTreeShowHidden=1 " This also ignores .gitignore
let NERDTreeIgnore=['.git$[[dir]]', '.swp']

autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p

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


""""""""""""""""""""""""""""""""""""""
" Vim Better Whitespace Configuration
"""""""""""""""""""""""""""""""""""""
autocmd BufWritePre * StripWhitespace


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

""""""""""""""
" vim-arline
""""""""""""""
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"

""""""""""""""""""""""""""""""""""""""""
" YouCompleteMe Space+G go-to-definition
""""""""""""""""""""""""""""""""""""""""
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>


""""""""""""""""
" Syntastic
"""""""""""""""
let g:syntastic_ruby_checkers = ['rubocop']

"""""""""
" CtrlP
"""""""""
" Some projects weren't getting all their files indexed,
" This allows all files to be indexed.
" (This will probably kill vim if this accidentally gets
"  ran on the home directory)
let g:ctrlp_max_files=0

" Do not index folders we are never going to care about
" NOTE: the regex OR operator needs to be escaped
let g:ctrlp_custom_ignore = 'node_modules\|bower_components\|DS_Store\|git'
