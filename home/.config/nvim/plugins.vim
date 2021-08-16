call plug#begin('~/.local/share/nvim/plugged')
  """""""""""""""""
  " Syntax / Theme
  Plug 'joshdick/onedark.vim'
  Plug 'sainnhe/edge'

  """""""""""""""""
  " Editor
  """""""""""""""""
  Plug 'ntpeters/vim-better-whitespace'
  autocmd BufWritePre * StripWhitespace

  " File / Project Finding
  Plug 'kyazdani42/nvim-web-devicons' " for file icons
  Plug 'kyazdani42/nvim-tree.lua'
  let g:nvim_tree_width = 40
  let g:nvim_tree_ignore = [ '.git', 'node_modules', '.cache', 'dist', 'tmp' ]
  let g:nvim_tree_window_picker_chars = "aoeuidhtnsgcrld;qjkxbmwv"
  let g:nvim_tree_highlight_opened_files = 0 " breaks icon color
  let g:nvim_tree_indent_markers = 1
  let g:nvim_tree_add_trailing = 1

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
  " Plug 'hoob3rt/lualine.nvim'
  Plug 'NullVoxPopuli/lualine.nvim', { 'branch': 'fix-estimated-with-calculation' }

  """""""""""""""""""""
  " Syntax Support

    " The Future of syntax highlighting
    Plug 'nvim-treesitter/nvim-treesitter'
    Plug 'nvim-treesitter/playground' " for debugging syntax / reporting bugs better

    " Fallback ember highlighting for when treesitter gets too experimental
    if $GLIMMER_LEGACY == 'true'
      Plug 'joukevandermaas/vim-ember-hbs'
      Plug 'dylnmc/synstack.vim' " For debugging traditional syntax plugins
    endif

    " Nested syntax highlighting (normally provided by tree-sitter)
    " needed for js/ts named template literals in markdown.
    Plug 'Quramy/vim-js-pretty-template'
    " TreeSitter doesn't yet have support for
    " - markdown
    if $MARKDOWN == 'true'
      Plug  'joukevandermaas/vim-ember-hbs'
      Plug 'plasticboy/vim-markdown'
    endif

    let g:vim_markdown_fenced_languages = ['js=javascript', 'ts=typescript', 'hbs=handlebars', 'bash=sh', 'cjs=javascript', 'mjs=javascript']
call plug#end()

