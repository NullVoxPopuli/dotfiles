" Don't care about compatibility
" More info:
" https://stackoverflow.com/questions/5845557/in-a-vimrc-is-set-nocompatible-completely-useless
set nocompatible

" Actual config split out here
so ~/.config/nvim/plugins.vim
so ~/.config/nvim/editor.vim
so ~/.config/nvim/functions.vim
so ~/.config/nvim/keymap.vim
so ~/.config/nvim/coc.vim

" Manual Syntaxes / Filetypes
autocmd BufNewFile,BufRead *.hbs setfiletype handlebars
autocmd BufNewFile,BufRead *.tsx,*.jsx setfiletype typescript.tsx
autocmd FileType javascript setlocal foldmethod=syntax
autocmd BufNewFile,BufRead *.json set ft=javascript

" Batch'd Setup / Config Scripts
call EnableTemplateLiteralColors()
