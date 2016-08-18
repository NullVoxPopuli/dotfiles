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
