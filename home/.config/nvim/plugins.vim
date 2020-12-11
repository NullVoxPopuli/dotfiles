call plug#begin('~/.local/share/nvim/plugged')
  """""""""""""""""
  " Syntax / Theme
  Plug 'joshdick/onedark.vim'

  """""""""""""""""
  " Editor
  """""""""""""""""
  Plug 'etdev/vim-hexcolor'
  Plug 'ntpeters/vim-better-whitespace'
  autocmd BufWritePre * StripWhitespace

  " File / Project Finding

  Plug 'dyng/ctrlsf.vim'
  let g:ctrlsf_default_root = 'cwd'
  let g:ctrlsf_auto_preview = 1
  let g:ctrlsf_auto_focus = {
      \ 'at': 'start',
      \ }
  let g:ctrlsf_extra_backend_args = {
      \ 'rg': '--hidden',
      \ }

  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.6, 'border': 'rounded' } }

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
  Plug 'tpope/vim-fugitive'

  """"""""""""""""""""
  " Language Servers
  "
  " Debugging:
  "   node -e 'console.log(path.join(os.tmpdir(), "coc-nvim.log"))'
  """"""""""""""""""""
  Plug 'neoclide/coc.nvim', {'branch': 'release'}

  """"""""""""""""""
  "" Status
  """"""""""""""""""
  Plug 'airblade/vim-gitgutter'
  Plug 'vim-airline/vim-airline'
  let g:airline_powerline_fonts = 1

  if !exists('g:airline_symbols')
    let g:airline_symbols = {}
  endif
  let g:airline#extensions#tabline#enabled = 0
  let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
  let g:airline#extensions#branch#enabled = 0

  " Configuration
  " A - display mode = flags
  " B - version control
  " C - file name
  " X - file type
  " Y - file encoding
  " Z - current position
  " ... addition stuff
  " https://github.com/vim-airline/vim-airline#configurable-and-extensible
  " function! AirlineInit()
  "   let g:airline_section_a = airline#section#create(['mode'])
  "   let g:airline_section_b = airline#section#create_left([])
  "   let g:airline_section_c = airline#section#create(['%f'])
  "   let g:airline_section_x = airline#section#create([''])
  "   let g:airline_section_y = airline#section#create(['filetype'])
  "   " let g:airline_section_z = airline#section#create(['percentage'])

  " endfunction
  " autocmd VimEnter * call AirlineInit()


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
  " the typescript package this uses isn't compat with jspretpml
  Plug 'sheerun/vim-polyglot'
  " handled below
  " let g:polyglot_disabled = ['css', 'ts', 'typescript', 'js', 'javascript', 'hbs', 'json']
  let g:polyglot_disabled = ['css', 'hbs', 'ts', 'typescript']
  set re=0
  " Polyglot Markdown provided by: https://github.com/plasticboy/vim-markdown
  let g:vim_markdown_fenced_languages = ['js=javascript', 'ts=typescript', 'hbs=html.handlebars', 'bash=sh']

  " CSS
  " Plug 'amadeus/vim-css'
  " Plug 'stephenway/postcss.vim'
  Plug 'alexlafroscia/postcss-syntax.vim'

  " Elixir
  Plug 'elixir-editors/vim-elixir'

  " Typescript syntax
  Plug 'leafgarland/typescript-vim'

  " JSONc - JSON, but with comments
  Plug 'neoclide/jsonc.vim'

  " JavaScript Syntax
  " Plug 'pangloss/vim-javascript'
  " let g:javascript_plugin_jsdoc = 1


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

