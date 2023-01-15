"
" aka "cheatsheet for how I use vim"
"
" ---------------------------------------
"
noremap <unique> ' <NOP>
" I use DVorak, so this is the "Q" position on qwerty keyboards
let mapleader = "\'"
let maplocalleader = "\'"

" use semicolon instead of colon for commands. one less keystroke.
nnoremap ; :

" swap navigation keys for more ergonomic navigation
" querty: h j k l -- left down up right (inline)
" dvorak: h t c n -- left down up right (WASD)
"
" NOTE: basic movement keys should not be remapped,
"       because so much in (neo)vim depends on hjkl, 
"       the other keys are generally used, so remap with caution.
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
"
" https://github.com/dyng/ctrlsf.vim#key-maps
" Enter - Open
" <C-O> - Open, but horizontal split
" O - Open, but leaze the search results
" q - quit
nnoremap <C-f> :lua require('spectre').open()<CR>

"search current word
nnoremap <leader>fw :lua require('spectre').open_visual({select_word=true})<CR>
vnoremap <leader>f :lua require('spectre').open_visual()<CR>
"  search in current file
nnoremap <leader>fp viw:lua require('spectre').open_file_search()<cr>


" Highlight the current word under cursor
"
" NOTES:
" - `"/' is the last search pattern register
" - `let @/ =' is used to write in the "/" register, e.g. ` :let @/ = "foobar"'
"
" TODO: Is there an easier / built-in way?
nnoremap <C-d> :let @/ = printf("\\<%s\\>", escape(expand('<cword>'), '/\'))<CR> :let &hlsearch = &hlsearch<CR>

"""
nnoremap <C-t> <CMD>Telescope smart_open<CR> 
" nmap <leader>gs :FzfLua git_status<CR>
" nmap <C-f> :Ag<CR>
nmap <leader><BSlash> :NvimTreeToggle<CR>
nmap <leader>l :NvimTreeFindFile<CR>

nnoremap <silent> <CR> :noh<CR><CR>

""""""""""""""""""
" Pane Management
""""""""""""""""""
" Convert Pane to Terminal
nnoremap <C-y> :IntegratedTerm<CR>

" Creating Panes
" chtn = up, left, down, right
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
nnoremap <S-h> :vertical resize -10<CR>
nnoremap <S-n> :vertical resize +10<CR>

" increase / decrease height or the "horizontal split"
nnoremap <S-t> :resize -10<CR>
nnoremap <S-c> :resize +10<CR>

" New Tab
nnoremap <C-p> :tabnew<CR>
nnoremap <A-]> :BufferLineCycleNext<CR>
nnoremap <A-[> :BufferLineCyclePrev<CR>

" Swap: Ctrl+W R
" Resizing
" Ctrl+w _ max out height of current split
" Ctrl+w | max out width of current split
" Ctrl+w = normalize all splits
" Ctrl+W o close every window but current

""""""""""""""""""""
" Spell Checking
""""""""""""""""""""
nnoremap <F2> :setlocal spell! spelllang=en_us<CR>

"""""""""""""""""""""
" Working with Code
"""""""""""""""""""""
" NOTE: C-_ is the same as C-/
" gc in visual mode
" for commenting
map <C-_> gcc

" Git 
nnoremap <leader>gs :LazyGit<CR>

" GitHub Copilot
" imap <silent><script><expr> <C-Space> copilot#Accept("\<CR>")
" let g:copilot_no_tab_map = v:true

" Recursively unfold
nnoremap <leader>z zczA

" Generate a GUID
nnoremap <F1> "=trim(system('uuidgen'))<CR>

" Move Lines Up/Down
nnoremap <C-j> :move+1<CR>
nnoremap <C-k> :move-2<CR>

" " vim-multiple-cursors keymap
" let g:multi_cursor_start_word_key      = '<C-Enter>'
" let g:multi_cursor_select_all_word_key = '<A-Enter>'
" let g:multi_cursor_start_key           = 'g<C-Enter>'
" let g:multi_cursor_select_all_key      = 'g<A-Enter>'
" let g:multi_cursor_next_key            = '<C-Enter>'
" let g:multi_cursor_prev_key            = '<C-Shift-Enter>'
" " let g:multi_cursor_skip_key            = '<C-x>'
" let g:multi_cursor_quit_key            = '<Esc>'

