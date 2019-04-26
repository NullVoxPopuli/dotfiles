call plug#begin('~/.local/share/nvim/plugged')
  """""""""""""""""
  " Syntax / Theme
  Plug 'joshdick/onedark.vim'

  """""""""""""""""
  " Editor
  """""""""""""""""

  Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
  let g:prettier#exec_cmd_async = 1
  let g:prettier#autoformat = 0

  Plug 'ntpeters/vim-better-whitespace'
  autocmd BufWritePre * StripWhitespace

  " Finding
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'scrooloose/nerdtree'
  Plug 'Xuyuanp/nerdtree-git-plugin'

  let NERDTreeShowHidden=0 " This also ignores .gitignore
  let NERDTreeIgnore=['.git$[[dir]]', '.swp', 'dist', 'tmp', 'node_modules', 'obj', 'bin', 'bower_components']
  let NERDTreeAutoDeleteBuffer = 1
  let NERDTreeMinimalUI = 1
  let NERDTreeDirArrows = 1

  " Working with code
  Plug 'jiangmiao/auto-pairs'
  let g:AutoPairsFlyMode = 1
  " M-b jumps back
  let g:AutoPairsShortcutJump = ''
  let g:AutoPairsShortcutFastWrap = ''



  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-commentary'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'w0rp/ale'
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  let g:deoplete#enable_at_startup = 1

  """"""""""""""""""
  " Status
  Plug 'airblade/vim-gitgutter'
  Plug 'vim-airline/vim-airline'
  let g:airline_powerline_fonts = 1

  if !exists('g:airline_symbols')
    let g:airline_symbols = {}
  endif
  let g:airline_symbols.space = "\ua0"
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#formatter = 'unique_tail_improved'

  """""""""""""""""""""
  " Syntax Support
  Plug 'OmniSharp/omnisharp-vim'
  Plug 'chr4/nginx.vim'
  Plug 'OrangeT/vim-csharp'
  let g:OmniSharp_server_path = '/home/lprestonsegoiii/Applications/omnisharp-x64/run'
  let g:OmniSharp_server_type = 'roslyn'
  let g:OmniSharp_timeout = 5

  " Typescript syntax highlighting
  Plug 'leafgarland/typescript-vim'
  let g:typescript_indent_disable = 1


  Plug 'joukevandermaas/vim-ember-hbs'
  " Typscript language server
  Plug 'mhartington/nvim-typescript', { 'do': './install.sh' }
  " Additional jsx highlighting
  Plug 'maxmellon/vim-jsx-pretty'
  let g:vim_jsx_pretty_colorful_config = 1

  """"""""""""""""""""""
  " Helpin with VIM
  Plug 'takac/vim-hardtime'
  let g:list_of_insert_keys = []
  let g:hardtime_timeout = 1500
  let g:hardtime_showmsg = 1

call plug#end()
