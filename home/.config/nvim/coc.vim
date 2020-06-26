let g:coc_global_extensions = [
  \ 'coc-actions',
  \ 'coc-explorer',
  \ 'coc-tsserver',
  \ 'coc-css',
  \ 'coc-eslint',
  \ 'coc-prettier',
  \ 'coc-json',
  \ 'coc-html',
  \ 'coc-vimlsp',
  \ 'coc-highlight',
  \ 'coc-ember',
  \ 'coc-elixir'
\ ]

"" Integrations
let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'

let g:coc_explorer_global_presets = {
\   'simplify': {
\     'file-child-template': '[selection | clip | 1] [indent][icon | 1] [filename omitCenter 1]'
\   }
\ }



"" Hot Keys
nnoremap <silent> <space>c :<C-u>CocList commands<cr>
inoremap <silent><expr> <c-space> coc#refresh()

" Remap keys for gotos
nmap <silent> <leader>gd <Plug>(coc-definition)
nmap <silent> <leader>gy <Plug>(coc-type-definition)
nmap <silent> <leader>gi <Plug>(coc-implementation)
nmap <silent> <leader>gr <Plug>(coc-references)

"" Remap for code action
nmap <leader><space> :call CocAction('doHover')<CR>

" Remap for do codeAction of selected region
function! s:cocActionsOpenFromSelected(type) abort
  execute 'CocCommand actions.open ' . a:type
endfunction
xmap <silent> <leader>a :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
nmap <silent> <leader>a :<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>g@

" <leader>a for the current selected range
" <leader>aw for the current word
" <leader>aas for the current sentence
" <leader>aap for the current paragraph



" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)
" Remap for format selected region
nmap <leader>ff :CocCommand eslint.executeAutofix<CR>
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f <Plug>(coc-format-selected)

"" Suggestion UX
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

