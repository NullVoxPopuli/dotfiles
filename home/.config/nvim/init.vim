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
so ~/.config/nvim/theme.vim
lua require('plugin-config/bufferline')
lua require('plugin-config/statusline')
lua require('plugin-config/colors')

" Manual Syntaxes / Filetypes
autocmd BufNewFile,BufRead *.hbs setfiletype handlebars
autocmd BufNewFile,BufRead *.tsx,*.gts setfiletype typescript.tsx
autocmd BufNewFile,BufRead *.jsx,*.gjs setfiletype typescript.tsx
" autocmd FileType javascript setlocal foldmethod=syntax

" tsconfig.json is actually jsonc, help TypeScript set the correct filetype
autocmd BufRead,BufNewFile *.json,*.json5 setfiletype jsonc

" Autosave after 'updatetime'
" autocmd CursorHold * wa

" Batch'd Setup / Config Scripts
call EnableTemplateLiteralColors()
