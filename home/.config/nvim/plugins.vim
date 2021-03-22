call plug#begin('~/.local/share/nvim/plugged')
  """""""""""""""""
  " Syntax / Theme
  Plug 'joshdick/onedark.vim'
  Plug 'sainnhe/edge'

  """""""""""""""""
  " Editor
  """""""""""""""""
  Plug 'etdev/vim-hexcolor'
  Plug 'ntpeters/vim-better-whitespace'
  autocmd BufWritePre * StripWhitespace

  " File / Project Finding
  Plug 'kyazdani42/nvim-web-devicons' " for file icons
  Plug 'kyazdani42/nvim-tree.lua'
  let g:nvim_tree_width = 40
  let g:nvim_tree_ignore = [ '.git', 'node_modules', '.cache', 'dist', 'tmp' ]

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
  Plug 'norcalli/nvim-colorizer.lua'
  Plug 'jiangmiao/auto-pairs'
  let g:AutoPairsFlyMode = 1
  " M-b jumps back
  let g:AutoPairsShortcutJump = ''
  let g:AutoPairsShortcutFastWrap = ''

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

    " The Future of syntax highlighting
    Plug 'nvim-treesitter/nvim-treesitter'
    Plug 'nvim-treesitter/playground' " for debugging syntax / reporting bugs better

    " Fallback ember highlighting for when treesitter gets too experimental
    if $GLIMMER_LEGACY == 'true'
      " Plug 'joukevandermaas/vim-ember-hbs'
      Plug 'NullVoxPopuli/vim-ember-hbs', { 'branch': 'minor-improvementns' }
      Plug 'dylnmc/synstack.vim' " For debugging traditional syntax plugins
    endif

    " Nested syntax highlighting (normally provided by tree-sitter)
    " needed for js/ts named template literals in markdown.
    Plug 'Quramy/vim-js-pretty-template'
    " TreeSitter doesn't yet have support for
    " - markdown
    if $MARKDOWN != 'true'
      Plug 'plasticboy/vim-markdown'
    endif

    let g:vim_markdown_fenced_languages = ['js=javascript', 'ts=typescript', 'hbs=handlebars', 'bash=sh']
call plug#end()

