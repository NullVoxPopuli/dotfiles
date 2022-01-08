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


augroup SyntaxAssignments
  autocmd!

  " Manual Syntaxes / Filetypes
  autocmd BufNewFile,BufRead *.hbs setfiletype handlebars
  autocmd BufNewFile,BufRead *.gts setfiletype typescript.glimmer
  autocmd BufNewFile,BufRead *.gjs setfiletype javascript.glimmer
  autocmd BufNewFile,BufRead *.tsx setfiletype typescript.tsx
  autocmd BufNewFile,BufRead *.jsx setfiletype typescript.tsx

  " tsconfig.json is actually jsonc, help TypeScript set the correct filetype
  " Set everything to jsonc, cause it's easier
  autocmd FileType json set filetype=jsonc
  autocmd FileType json5 set filetype=jsonc
augroup END

" Autosave after 'updatetime'
" autocmd CursorHold * wa

" Batch'd Setup / Config Scripts
call EnableTemplateLiteralColors()

