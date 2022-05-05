" Removed tslint because it always runs
" it'd be great if tslint only ran in tslint projects
let g:coc_global_extensions = [
  \ 'coc-diagnostic',
  \ 'coc-sh',
  \ 'coc-git',
  \ 'coc-glint',
  \ 'coc-spell-checker',
  \ 'coc-conventional',
  \ 'coc-tailwindcss',
  \ 'coc-tsserver',
  \ 'coc-css',
  \ 'coc-eslint',
  \ 'coc-json',
  \ 'coc-html',
  \ 'coc-lua',
  \ 'coc-vimlsp',
  \ 'coc-ember',
  \ 'coc-stylelintplus',
  \ 'coc-elixir',
  \ 'coc-fsharp',
  \ 'coc-yaml'
\ ]

"" Hot Keys
nnoremap <silent> <space>c :<C-u>CocList commands<cr>
inoremap <silent><expr> <c-space> coc#refresh()

" Remap keys for gotos
nmap <silent> <leader>gd <Plug>(coc-definition)
nmap <silent> <leader>gy <Plug>(coc-type-definition)
nmap <silent> <leader>gi <Plug>(coc-implementation)
nmap <silent> <leader>gr <Plug>(coc-references)

"" Remap for code action
nmap <leader><space> :call CocActionAsync('doHover')<CR>
nmap <leader>cl <Plug>(coc-codelens-action)

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
" <leader>aw for current word
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)

" <leader>a for the current selected range
" <leader>aw for the current word
" <leader>aas for the current sentence
" <leader>aap for the current paragraph



" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)
nmap <F3> :call BackUpFormatter()<cr>
nmap <expr> <leader>ff CocHasProvider('format') ? "\<Plug>(coc-format)" : ":call BackUpFormatter()\<cr>"
function! BackUpFormatter()
  let ext = expand('%:e')
  let theFile = expand('%:p')

  if ext == "hbs"
    echo system('hbs-lint ' . shellescape(theFile))
    :e
  endif
endfunction

" Remap for format selected region
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f <Plug>(coc-format-selected)

"" Suggested UX
"" https://github.com/neoclide/coc.nvim/wiki/Completion-with-sources#improve-completion-experience
"" Navigation
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" NOTE: using tab for this makes TAB not work as normal tab insersion...
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
" inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : <SID>check_back_space() ? "\<TAB>" : coc#refresh()

inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

"" Use enter to confirm completion
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

"" Close preview window when completion is done.
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap <C-j> and <C-k> for scroll float windows/popups.
nnoremap <silent><nowait><expr> <C-j> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-j>"
nnoremap <silent><nowait><expr> <C-k> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-k>"
inoremap <silent><nowait><expr> <C-j> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <silent><nowait><expr> <C-k> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
vnoremap <silent><nowait><expr> <C-j> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-j>"
vnoremap <silent><nowait><expr> <C-k> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-k>"
