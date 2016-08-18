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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Notes for myself, because holy cow, there are a lot of shortcuts
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" gt/gT - switch tabs (prev/next)
" <C-w w> switch panes (randomly?)
" :m # - moves line below the specified line number
" :#,#m # - moves line range to line below specified number
" :m +# to move it # lines up

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

" Make home got to the first non-whitespace character on the line
:imap <Home> <Esc>^i
map <Home> ^

" Shift Home goes to the beginning of the line
:imap <S-<Home>> <Esc>0i
map <S-<Home>> 0


""""""""""""""
" Commenting
""""""""""""""
" https://github.com/scrooloose/nerdcommenter
" 'cc comments out line or selection
" 'c<space> toggles comment
map <leader>/   <plug>NERDCommenterToggle


"""""""""""""
" Ctrl-P
""""""""""""
" remap to control t because t is more natural on DVorak
let g:ctrlp_map = '<c-t>'
