so ~/.vim/vimrc/plugin-configs/nerdtree.vim
so ~/.vim/vimrc/plugin-configs/indentline.vim
so ~/.vim/vimrc/plugin-configs/nerdcommenter.vim
so ~/.vim/vimrc/plugin-configs/vim-airline.vim

""""""""""""""""""""""""""""""""""""""
" Vim Better Whitespace Configuration
"""""""""""""""""""""""""""""""""""""
autocmd BufWritePre * StripWhitespace


""""""""""""""""""""""""""""""""""""""""
" YouCompleteMe Space+G go-to-definition
""""""""""""""""""""""""""""""""""""""""
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>


""""""""""""""""
" Syntastic
"""""""""""""""
let g:syntastic_ruby_checkers = ['rubocop']

"""""""""
" ripgrep
"""""""""
let g:rg_command = '
  \ rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --color "always"
  \ -g "*.{js,json,php,md,styl,jade,html,config,py,cpp,c,go,hs,rb,conf}"
  \ -g "!{.git,node_modules,vendor}/*" '

command! -bang -nargs=* F call fzf#vim#grep(g:rg_command .shellescape(<q-args>), 1, <bang>0)
