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


function UpdateAll()
 :CocUpdate
 :TSUpdate
 :PackerSync
endfunction
