call plug#begin('~/.local/share/nvim/plugged')
  """""""""""""""""
  " Syntax / Theme
  Plug 'joshdick/onedark.vim'

  """""""""""""""""
  " Editor
  """""""""""""""""
  Plug 'ntpeters/vim-better-whitespace'
  autocmd BufWritePre * StripWhitespace

  " File / Project Finding

  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'

  " File Tree Browser
  Plug 'scrooloose/nerdtree'
  Plug 'Xuyuanp/nerdtree-git-plugin'

  let NERDTreeShowHidden=1 " This also ignores .gitignore
  let NERDTreeIgnore=['.git$[[dir]]', '.swp', 'dist', 'tmp', 'node_modules', 'bower_components', '.pnp']
  let NERDTreeAutoDeleteBuffer = 1
  let NERDTreeMinimalUI = 1
  let NERDTreeDirArrows = 1

  " Working with code
  Plug 'jiangmiao/auto-pairs'
  let g:AutoPairsFlyMode = 1
  " M-b jumps back
  let g:AutoPairsShortcutJump = ''
  let g:AutoPairsShortcutFastWrap = ''

  " Plug 'terryma/vim-multiple-cursors'
  " let g:multi_cursor_use_default_mapping=0

  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-commentary'

  Plug 'editorconfig/editorconfig-vim'

  " Git Conflict highlighting
  Plug 'rhysd/conflict-marker.vim'

  """"""""""""""""""""
  " Language Servers
  "
  " Debugging:
  "   node -e 'console.log(path.join(os.tmpdir(), "coc-nvim.log"))'
  """"""""""""""""""""
  Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}

  """"""""""""""""""
  "" Status
  """"""""""""""""""
  Plug 'airblade/vim-gitgutter'
  Plug 'vim-airline/vim-airline'
  let g:airline_powerline_fonts = 1

  if !exists('g:airline_symbols')
    let g:airline_symbols = {}
  endif
  let g:airline_symbols.space = "\ua0"
  let g:airline#extensions#tabline#enabled = 0
  let g:airline#extensions#tabline#formatter = 'unique_tail_improved'

  """""""""""""""""""""
  " Syntax Support

  " .net language server and highlighting support
  " Plug 'OmniSharp/omnisharp-vim'
  " Plug 'OrangeT/vim-csharp'
  " let g:OmniSharp_server_path = '/home/lprestonsegoiii/Applications/omnisharp-x64/run'
  " let g:OmniSharp_server_type = 'roslyn'
  " let g:OmniSharp_timeout = 5

  " Syntax not needed, because provided by polyglot
  "
  " toml: cespare/vim-toml
  " json5: GutenYe/json5.vim
  " josn: elzr/vim-json
  " nginx: chr4/nginx.vim
  Plug 'sheerun/vim-polyglot'
  " handled below
  let g:polyglot_disabled = ['css', 'ts', 'typescript', 'js', 'javascript', 'hbs', 'json']

  " CSS
  " Plug 'amadeus/vim-css'
  " Plug 'stephenway/postcss.vim'
  Plug 'alexlafroscia/postcss-syntax.vim'

  " Elixir
  Plug 'elixir-editors/vim-elixir'

  " Typescript syntax
  Plug 'leafgarland/typescript-vim'

  " JavaScript Syntax
  Plug 'pangloss/vim-javascript'
  let g:javascript_plugin_jsdoc = 1


  " Plug 'HerringtonDarkholme/yats.vim'
  " Ember template highlighting
  Plug 'joukevandermaas/vim-ember-hbs'

  " Additional jsx highlighting
  " Plug 'maxmellon/vim-jsx-pretty'
  " let g:vim_jsx_pretty_colorful_config = 1

  " Nested syntax highlighting
  " needed for js/ts named template literals
  " and markdown.
  Plug 'Quramy/vim-js-pretty-template'

call plug#end()

