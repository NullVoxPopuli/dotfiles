" Don't care about compatibility
set nocompatible
so ~/.config/nvim/plugins.vim
so ~/.config/nvim/editor.vim

:function TabsToSpaces()
:  set tabstop=2 shiftwidth=2 expandtab
:  retab
:endfunction

" Manual Syntaxes / Filetypes
autocmd BufNewFile,BufRead *.hbs setfiletype handlebars
" The typescript filetype breaks on attributes with backticks
:function SetTSXConfig()
:  set filetype=typescript
:endfunction

autocmd BufNewFile,BufRead *.tsx,*.jsx :call SetTSXConfig()

"""""""""""""""""""""""""""""""
" Finally, load the keymap....
"""""""""""""""""""""""""""""""
so ~/.config/nvim/keymap.vim
" so ~/.config/nvim/oni-config.vim
