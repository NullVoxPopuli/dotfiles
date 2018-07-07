" use a leader key that is easier to reach for dvorak
noremap <unique> ' <NOP>
let mapleader = "\'"
let maplocalleader = "\'"

" use semicolon instead of colon for commands. one less keystroke.
nnoremap ; :

" swap navigation keys for more ergonomic navigation
" querty: h j k l -- left down up right (inline)
" dvorak: h t c n -- left down up right (WASD)
" querty: j k i l -- left down up right (WASD)
"
" NOTE: h doesn't need to be re-mapped, because it happens to be 
"       in the right spot for right-hand dvorak wasd
"       
" consider http://vimcasts.org/blog/2013/02/habit-breaking-habit-making/

"""""""""""""""""""
" File Management
"""""""""""""""""""
" Save.
map <C-s> :w<CR>
imap <C-s> <ESC>:w<CR>
" Quit
nmap <leader>, :q<CR>
nmap <leader>. :qa<CR>
" Line Navigation
"  {num}+ {num}-
"  find way to map the + command to =, because I don't want to hit shift

" Search
nmap <C-t> :Files<CR>
nmap <C-f> :Ag<CR>


""""""""""""""""""
" Pane Management
""""""""""""""""""

" Creating Panes
nmap <leader>c :leftabove new<CR>
nmap <leader>h :leftabove vnew<CR>
nmap <leader>t :rightbelow new<CR>
nmap <leader>n :rightbelow vnew<CR>

" Switching Panes
nnoremap <A-c> <C-w><C-k>
nnoremap <A-h> <C-w><C-h>
nnoremap <A-t> <C-w><C-j>
nnoremap <A-n> <C-w><C-l>

" Swap: Ctrl+W R
" Resizing
" Ctrl+w _ max out height of current split
" Ctrl+w | max out width of current split
" Ctrl+w = normalize all splits
" Ctrl+W o close every window but current




""""""""""""""""""
" Utility
""""""""""""""""""
nmap <leader>H <ESC>:HardTimeToggle<CR>
