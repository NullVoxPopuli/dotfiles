" Don't care about compatibility
" More info:
" https://stackoverflow.com/questions/5845557/in-a-vimrc-is-set-nocompatible-completely-useless
set nocompatible

" Actual config split out here
lua require('plugins')
so ~/.config/nvim/editor.vim
so ~/.config/nvim/functions.vim
so ~/.config/nvim/keymap.vim
so ~/.config/nvim/coc.vim
so ~/.config/nvim/theme.vim

lua << EOF
-- I don't think anything uses this yet
--  vim.notify = require("notify")
require('nvim-autopairs').setup{}
EOF


augroup ShouldBeDefaults
  autocmd!
  " tsconfig.json is actually jsonc, help TypeScript set the correct filetype
  " Set everything to jsonc, cause it's easier
  autocmd FileType json set filetype=jsonc
  autocmd FileType json5 set filetype=jsonc

  let g:coc_filetype_map = {
    \ 'typescript.glimmer': 'Glimmer TS',
    \ 'javascript.glimmer': 'Glimmer JS',
    \ }

  " This should be a default
  autocmd BufWritePre * StripWhitespace
augroup END


" Autosave after 'updatetime'
" autocmd CursorHold * wa
