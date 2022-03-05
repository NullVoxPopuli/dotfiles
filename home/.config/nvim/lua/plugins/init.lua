-- Automatically install packer
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd 'packadd packer.nvim'
end


-- :PackerCompile
-- :PackerClean
-- :PackerInstall
-- :PackerUpdate
-- :PackerSync
require('packer').startup(function(use)
  -- Plugins with too much config to have all in
  -- the same file
  require('plugins.highlighting')(use)
  require('plugins.statusline')(use)
  require('plugins.browsing')(use)
  require('plugins.finding')(use)

  -- NOTE: previously tried plugins
  --   twilight.nvim
  --     - loses highlights on dim
  --   shade.nvim
  --     - buggy, tries to dim buffer that doesn't exist
  --     - previous opacity: 85
  ----------------------

  -- Scripting Utilities
  use 'nvim-lua/plenary.nvim'
  -- use 'rcarriga/nvim-notify'

  ----------------------
  -- Syntax / Theme
  ----------------------
  use 'joshdick/onedark.vim'
  use 'sainnhe/edge'

  ----------------------
  -- Editor Behavior
  ----------------------
  use 'tpope/vim-surround'
  use 'tpope/vim-commentary'
  use 'tpope/vim-fugitive'
  use 'ntpeters/vim-better-whitespace'
  use 'windwp/nvim-autopairs'
  use 'editorconfig/editorconfig-vim'
  use {
    'abecodes/tabout.nvim',
    config = function()
      require('tabout').setup {}
    end,
    wants = { 'nvim-treesitter' },
    after = { 'coc.nvim' }
  }

  -- https://github.com/Pocco81/DAPInstall.nvim
  -- use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }
  ----------------------
  -- Information
  ----------------------
  use { 'neoclide/coc.nvim', branch = 'release' }
  use 'airblade/vim-gitgutter'
  -- colorize various color-like tokens in code
  use 'norcalli/nvim-colorizer.lua'
  -- tree-sitter plugin, colorizez brackets and parens
  use 'p00f/nvim-ts-rainbow'

  --  ¯\_( ツ )_/¯
  -- kinda broken -- overriding tab breaks everything
  -- issues are disabled on the repo, no support
  -- use { 'github/copilot.vim' }



  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

