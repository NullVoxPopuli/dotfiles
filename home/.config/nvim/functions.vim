
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

" The typescript filetype breaks on attributes with backticks
:function SetTSXConfig()
:  set filetype=typescript
:endfunction


