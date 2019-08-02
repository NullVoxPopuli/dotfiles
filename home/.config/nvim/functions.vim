" https://github.com/neoclide/coc.nvim/wiki/Completion-with-sources#use-tab-or-custom-key-for-trigger-completion
" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction


let g:syntastic_is_open = 0
function! SyntasticToggle()
if g:syntastic_is_open == 1
    lclose
    let g:syntastic_is_open = 0
else
    lopen
    let g:syntastic_is_open = 1
endif
endfunction


:function TabsToSpaces()
:  set tabstop=2 shiftwidth=2 expandtab
:  retab
:endfunction

" Allow for named template literals to be highlighted
" in a different syntax than the main buffer.
" https://github.com/Quramy/vim-js-pretty-template
function EnableTemplateLiteralColors()
  " list of named template literal tags and their syntax here
  call jspretmpl#register_tag('hbs', 'handlebars')

  autocmd FileType javascript JsPreTmpl
  autocmd FileType typescript JsPreTmpl

  " compat with leafgarland/typescript-vim
  autocmd FileType typescript syn clear foldBraces
endfunction
