" Don't care about compatibility
set nocompatible
so ~/.config/nvim/plugins.vim
so ~/.config/nvim/editor.vim
so ~/.config/nvim/functions.vim
so ~/.config/nvim/keymap.vim

" Manual Syntaxes / Filetypes
autocmd BufNewFile,BufRead *.hbs setfiletype handlebars
autocmd BufNewFile,BufRead *.tsx,*.jsx :call SetTSXConfig()
