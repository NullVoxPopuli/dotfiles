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



" YouCompleteMe Space+G go-to-definition
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>


""""""""""""""""
" Syntastic
"""""""""""""""
let g:syntastic_ruby_rubocop_exec = exepath(ruby) exepath(rubocop)
