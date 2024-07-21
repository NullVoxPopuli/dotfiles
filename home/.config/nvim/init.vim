" Don't care about compatibility
" More info:
" https://stackoverflow.com/questions/5845557/in-a-vimrc-is-set-nocompatible-completely-useless
set nocompatible

" Activate aggressive cache
lua require('impatient')

" Actual config split out here
lua require('plugins')
so ~/.config/nvim/theme.vim
lua require('plugin-config')
so ~/.config/nvim/editor.vim
so ~/.config/nvim/functions.vim
so ~/.config/nvim/keymap.vim
so ~/.config/nvim/clients/init.vim
so ~/.config/nvim/terminal.vim

" Loads the .bash_profile
set shell=/bin/bash\ --login

augroup ShouldBeDefaults
  autocmd!
  " tsconfig.json is actually jsonc, help TypeScript set the correct filetype
  " Set everything to jsonc, cause it's easier
  autocmd FileType json set filetype=jsonc
  autocmd FileType json5 set filetype=jsonc
  autocmd BufRead *.mts set filetype=typescript
  autocmd BufRead *.edge set filetype=html

  " Don't open a file with all the folds closed
  " Not needed with UFO
  " autocmd BufReadPost,FileReadPost * normal zR
augroup END


" Autosave after 'updatetime'
" autocmd CursorHold * wa


let g:closetag_filenames = '*.html,*.xhtml,*.gjs,*.gts,*.cshtml'
