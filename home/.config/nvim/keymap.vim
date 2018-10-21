
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

" Copy / Paste out / into vim
noremap <leader>y "+y
noremap <leader>p "+p

" Search
nmap <C-t> :Files<CR>
nmap <C-f> :Ag<CR>
nmap <leader><BSlash> :NERDTreeToggle<CR>
nmap <leader>l :NERDTreeFind<CR>
nnoremap <silent> <CR> :noh<CR><CR>

""""""""""""""""""
" Pane Management
""""""""""""""""""
" Convert Pane to Terminal
nnoremap <C-y> :terminal<CR>

" Creating Panes
nnoremap <leader>c :leftabove new<CR>
nnoremap <leader>h :leftabove vnew<CR>
nnoremap <leader>t :rightbelow new<CR>
nnoremap <leader>n :rightbelow vnew<CR>

" Switching Panes
nnoremap <A-c> <C-w><C-k>
nnoremap <A-h> <C-w><C-h>
nnoremap <A-t> <C-w><C-j>
nnoremap <A-n> <C-w><C-l>

" Resizing Panes
" increase / decrease width or the "vertical split"
nnoremap <C-k> :vertical resize -10<CR>
nnoremap <C-j> :vertical resize +10<CR>

" increase / decrease height or the "horizontal split"
nnoremap <C-e> :resize -10<CR>
nnoremap <C-u> :resize +10<CR>


" Swap: Ctrl+W R
" Resizing
" Ctrl+w _ max out height of current split
" Ctrl+w | max out width of current split
" Ctrl+w = normalize all splits
" Ctrl+W o close every window but current


"""""""""""""""""""""
" Working with Code
"""""""""""""""""""""
" NOTE: C-_ is the same as C-/
" gc in visual mode
map <C-_> gcc

" Suggestion
inoremap <silent><expr> <C-Space> pumvisible() ? "\<C-n>" : deoplete#mappings#manual_complete()


" C# / F# (Omnisharp)
" https://github.com/OmniSharp/omnisharp-vim#example-vimrc
autocmd FileType cs nnoremap <buffer> <leader>gd :OmniSharpGotoDefinition<CR>
autocmd FileType cs nnoremap <buffer> <leader>fx :OmniSharpFixUsings<CR>
autocmd FileType cs nnoremap <buffer> <leader><space> :OmniSharpGetCodeActions<CR>

""""""""""""""""""
" Utility
""""""""""""""""""
nmap <leader>H <ESC>:HardTimeToggle<CR>
