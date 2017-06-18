set nocompatible " Fixes old Vi bugs
filetype off

so ~/.vim/vimrc/plug.vim

filetype plugin indent on

so ~/.vim/vimrc/session.vim
so ~/.vim/vimrc/keymap.vim
so ~/.vim/vimrc/ui.vim
so ~/.vim/vimrc/indentation.vim


if has('nvim')
" let alt 'send' ESC key
let s:printable_ascii = map(range(32, 126), 'nr2char(v:val)')
call remove(s:printable_ascii, 92)
for s:char in s:printable_ascii
    execute "inoremap <A-" . s:char . "> <Esc>" . s:char
endfor
unlet s:printable_ascii s:char
else
  " vim needs the alt key hacked
  " https://github.com/matze/vim-move/issues/8
  " Basically, the terminal intercepts the alt key, and vim only
  " sees it as ESC -- not cool.
  let c='a'
  while c <= 'z'
    exec "set <A-".c.">=\e".c
    exec "imap \e".c." <A-".c.">"
    let c = nr2char(1+char2nr(c))
  endw
endif
set timeout ttimeoutlen=50
