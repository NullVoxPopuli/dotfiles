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
so ~/.config/nvim/treesitter.vim

" Manual Syntaxes / Filetypes
autocmd BufNewFile,BufRead *.hbs setfiletype handlebars
autocmd BufNewFile,BufRead *.tsx,*.jsx setfiletype typescript.tsx
autocmd FileType javascript setlocal foldmethod=syntax

" tsconfig.json is actually jsonc, help TypeScript set the correct filetype
" autocmd BufRead,BufNewFile tsconfig.json,tsconfig*.json set syntax=json5
autocmd BufRead,BufNewFile tsconfig.json,tsconfig*.json set filetype=jsonc
autocmd BufRead,BufNewFile *.json5 set filetype=jsonc

" Syntax highlighting breaks sometimes...
autocmd BufEnter * syntax sync fromstart

" Autosave after 'updatetime'
" autocmd CursorHold * wa

" Batch'd Setup / Config Scripts
call EnableTemplateLiteralColors()
