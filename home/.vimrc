set nocompatible " Fixes old Vi bugs
filetype off

so .vim/vimrc/vundle.vim

filetype plugin indent on


so .vim/vimrc/keymap.vim
so .vim/vimrc/ui.vim
so .vim/vimrc/indentation.vim
so .vim/vimrc/plugin-config.vim


" YouCompleteMe Space+G go-to-definition
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>


""""""""""""""""""""""
" Hacks n' Things
""""""""""""""""""""""
" https://github.com/matze/vim-move/issues/8
" Basically, the terminal intercepts the alt key, and vim only
" sees it as ESC -- not cool.
let c='a'
while c <= 'z'
  exec "set <A-".c.">=\e".c
  exec "imap \e".c." <A-".c.">"
  let c = nr2char(1+char2nr(c))
endw

set timeout ttimeoutlen=50
