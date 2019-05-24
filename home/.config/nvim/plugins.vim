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
  let NERDTreeIgnore=['.git$[[dir]]', '.swp', 'dist', 'tmp', 'node_modules', 'obj', 'bin', 'bower_components', '.pnp']
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

  " Linting
  Plug 'w0rp/ale'

  " Intellisense
  " Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  " let g:deoplete#enable_at_startup = 1

  """"""""""""""""""""
  " Language Servers
  "
  " Debugging:
  "   node -e 'console.log(path.join(os.tmpdir(), "coc-nvim.log"))'
  """"""""""""""""""""
  Plug 'neoclide/coc.nvim', { 'tag': '*', 'do': './install.sh' }
  " Note: Installing these via plug prevents auto-update
  Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
  Plug 'neoclide/coc-css', {'do': 'yarn install --frozen-lockfile'}
  Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}
  Plug 'neoclide/coc-html', {'do': 'yarn install --frozen-lockfile'}
  Plug 'iamcco/coc-vimlsp', {'do': 'yarn install --frozen-lockfile'}
  Plug 'neoclide/coc-highlight', {'do': 'yarn install --frozen-lockfile'}


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

  " .net language server and highlighting support
  " Plug 'OmniSharp/omnisharp-vim'
  " Plug 'OrangeT/vim-csharp'
  " let g:OmniSharp_server_path = '/home/lprestonsegoiii/Applications/omnisharp-x64/run'
  " let g:OmniSharp_server_type = 'roslyn'
  " let g:OmniSharp_timeout = 5

  " nginax highlighting
  Plug 'chr4/nginx.vim'

  " Typescript syntax highlighting
  Plug 'leafgarland/typescript-vim'
  " let g:typescript_indent_disable = 1


  " Ember template highlighting
  Plug 'joukevandermaas/vim-ember-hbs'
  " Typscript language server
  " Plug 'mhartington/nvim-typescript', { 'do': './install.sh' }
  " Additional jsx highlighting
  Plug 'maxmellon/vim-jsx-pretty'
  let g:vim_jsx_pretty_colorful_config = 1

call plug#end()
