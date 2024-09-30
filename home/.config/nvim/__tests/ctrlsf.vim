call plug#begin('~/.local/share/nvim/plugged')

  Plug 'dyng/ctrlsf.vim'
  let g:ctrlsf_default_root = 'cwd'
  let g:ctrlsf_auto_focus = {
      \ 'at': 'start',
      \ }

call plug#end()

nmap <C-f> <Plug>CtrlSFPrompt
vmap <C-f> <Plug>CtrlSFVwordExec
