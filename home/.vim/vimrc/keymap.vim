"""""""""""""""""""""""""""""""""""""""""""
" Commands / Key Mappings
""""""""""""""""""""""""""""""""""""""""""
" http://vim.wikia.com/wiki/Mapping_keys_in_Vim_-_Tutorial_(Part_1)
" <S-...> Shift
" <C-...> Control
" <M-...> Alt
" <A-...> Alt
" <D-...> command (moc only) super?

" I use DVorak... So vim is a little harder... yay.
" This maps the querty keys to the equiv dvorak for home position
" This notation is: <dvorak><querty>
" H - Left, K - Up, L - Right, J - Down
" I prefer WASD-inspired: h-left, t-down, n-right, c-up
" The vim equiv    :      h       j       l        k
" The querty wasd  :      j       k       l        i
" NOTE: h doesn't get remapped. It _happens_ to be in the right spot
" NOTE: the 4th and onward mappings are fixing what the first 3 break
" The downside to using n for right, is that dvorak-n is query-l,
set langmap=tj,ck,nl,jc,kv,ln

" Henceforth, anytime I want to use a dovark key, I must instead specify,
"             and promise to NOTE in the map, indicating the weird:
"             t => j
"             c => k
"             n => l
"             j => c
"             k => v
"             l => n


" Use Single quote for the <leader> key, cause it's closer than the default
" back slash
noremap ' <NOP>
let mapleader = "'"

" Use Semicolon instead of colon for commands
" Two less keystrokes
nnoremap ; :


"""""""""""""""""""""""""""""""
" Pane Switching
""""""""""""""""""""""""""""""
nnoremap <A-h> <C-w>h
nnoremap <A-t> <C-w>t
nnoremap <A-n> <C-w>n
nnoremap <A-c> <C-w>c

" Pane Creating
nmap <leader>cc :leftabove new<CR>
nmap <leader>hh :leftabove vnew<CR>
nmap <leader>tt :rightbelow new<CR>
nmap <leader>nn :rightbelow vnew<CR>

" Pane Re-Sizing
map <S-F5> :vertical resize +10<CR>
map <F5> :vertical resize +2<CR>
map <S-F6> :resize -10<CR>
map <F6> :resize -2<CR>
map <S-F7> :resize +10<CR>
map <F7> :resize +2<CR>
map <S-F8> :vertical resize -10<CR>
map <F8> :vertical resize -2<CR>

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

""""""""""""""""""""""""""""""""""""""
" Nerd Tree-Specfic Window Management
"""""""""""""""""""""""""""""""""""""
" o: preview
" t: open in new tab
" T: open in new tab silently
" i: open split
" gi: preview split
" s: open vsplit
" gs: preview vsplit


" Toggle Nerd Tree
nmap <leader><BSlash> :NERDTreeToggle <CR>
" Toggle focus to Nerd Tree
nmap <leader>n :NERDTreeFind<CR>

" s - splits to the right
" o - splits below


" Tab-Completion?
" imap <Tab> <C-P>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Notes for myself, because holy cow, there are a lot of shortcuts
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" gt/gT - switch tabs (prev/next)
" <C-w w> switch panes (randomly?)
" :m # - moves line below the specified line number
" :#,#m # - moves line range to line below specified number
" :m +# to move it # lines up
" o - new line below
" shift o - new line above

" Live Moving (Up and Down)
" Set to control (<A-k> : up, <A-j> : down)
inoremap <A-t> <Esc>:m .+1<CR>==gi
inoremap <A-c> <Esc>:m .-2<CR>==gi


"""""""""""""
" Navigation
"""""""""""""
" Exit insert mode upon arrow key navigation
inoremap <silent> <Up> <ESC><Up>
inoremap <silent> <Down> <ESC><Down>

" Make home got to the first non-whitespace character on the line
imap <Home> <Esc>^i
map <Home> ^

" Shift Home goes to the beginning of the line
imap <S-<Home>> <Esc>0i
map <S-<Home>> 0


""""""""""""""
" Commenting
""""""""""""""
" https://github.com/scrooloose/nerdcommenter
" 'cc comments out line or selection
" 'c<space> toggles comment
" map <C-=> <plug>NERDCommenterToggle<CR>

"nmap <C-/> <Plug>NERDCommenterToggle('n', 'Toggle')<CR>


"""""""""""""
" File Finding
"""""""""""""
nmap <C-t> :Files<CR>
nmap <C-f> :Ag<CR>


" Sensible Indentation with Tab!
vmap <TAB> >gv
vmap <S-TAB> <gv

" Auto-Correct Ruby
map <leader>r :!rubocop -a % <CR>

" Save, cause habits
map <C-s> :w<CR>
imap <C-s> <Esc>:w<CR>

" Quit one pane"
nmap <leader>w :q<CR>
" Quit EVERYTHING - (Triggers session save)
nmap <leader>q :qa<CR>

"""""""""""""""""""""""
" Indentation Fixing
"""""""""""""""""""""""
nmap <leader><Tab><Space> :set expandtab <CR>:retab<CR>
nmap <leader><Space><Tab> :set noexpandtab<CR>:retab!<CR>


""""""""""""""""""""""
" Git
"""""""""""""""""""""
nmap <leader>gb :Gblame<CR>
