" True Colors (tm)
set termguicolors

" Dark background is best background
set background=dark

""""""""""""""""""""""""""
" Theme: onedark
"        Plug 'joshdick/onedark.vim'
"
" colorscheme onedark


""""""""""""""""""""""""""
" Theme: Edge
"        Plug 'sainnhe/edge'
"
let g:edge_style = 'neon'
let g:edge_enable_italic = 1
let g:edge_better_performance = 1
let g:edge_dim_foreground = 0
let g:edge_dim_inactive_windows = 1
colorscheme edge

" No theme has 100% of what I want.
" Here is where I override the theme's settings
highlight! link CocExplorerFileDirectory Blue
" default neon bg: 2b2d3a
highlight! Normal guibg=#202230
highlight! Terminal guibg=#202230
highlight! EndOfBuffer guibg=#202230
" default neon bg: 2f3242
highlight! SignColumn guibg=#262836
" disable italic on Type
highlight! Type cterm=NONE gui=NONE guifg=#9988cc
" most themes link TS Groups to Basic AF colors
highlight! TSType guifg=#cc9988
highlight! TSTypeBuiltin guifg=#bbaadd
" Too much red
highlight! TSProperty guifg=#bbccff
" highlight! TSParameter guifg=#ff88cc
highlight! TSVariable guifg=#ff8888
highlight! TSVariableBuiltin guifg=#9999bb
highlight! TSTag guifg=#ff99cc
highlight! TSTagDelimiter guifg=#ffccff
highlight! TSURI guifg=#559999



highlight! CursorLine guibg=#262836
highlight! CursorColumn guibg=#262836

highlight! RedSign guibg=#262836
highlight! YellowSign guibg=#262836
highlight! GreenSign guibg=#262836
highlight! BlueSign guibg=#262836
highlight! PurpleSign guibg=#262836

" nvim-tree.lua
" :help nvim_tree_highlight
highlight NvimTreeIndentMarker guifg=#333333

" The divider lines
highlight! VertSplit guifg=#000000 guibg=NONE
highlight! HorSplit guifg=#000000 guibg=NONE
