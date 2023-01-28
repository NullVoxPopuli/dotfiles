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
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- *aggressive* caching
  use 'lewis6991/impatient.nvim'

  -- Plugins with too much config to have all in
  -- the same file
  require('plugins.lsp')(use)
  require('plugins.debugging')(use)
  require('plugins.linting')(use)
  require('plugins.syntax')(use)
  require('plugins.statusline')(use)
  require('plugins.browsing')(use)
  require('plugins.finding')(use)
  require('plugins.visuals')(use)

  -- NOTE: previously tried plugins
  --   twilight.nvim
  --     - loses highlights on dim
  --   shade.nvim
  --     - buggy, tries to dim buffer that doesn't exist
  --     - previous opacity: 85
  ----------------------

  -- Scripting Utilities
  use 'nvim-lua/plenary.nvim'
  use 'rcarriga/nvim-notify'

  ----------------------
  -- Editor Behavior
  ----------------------
  use 'tpope/vim-surround'
  use 'tpope/vim-commentary'
  use 'kdheepak/lazygit.nvim'
  use 'windwp/nvim-autopairs'
  use 'mg979/vim-visual-multi'
  use 'editorconfig/editorconfig-vim'
  use {
    'abecodes/tabout.nvim',
    config = function()
      require('tabout').setup {}
    end,
    wants = { 'nvim-treesitter' }
  }

  --  ¯\_( ツ )_/¯
  if os.getenv("COPILOT") == "true" then
    -- Not very efficient.
    -- copilot.lua explains why to use the 
    -- lua version over GitHub's own plugin
    -- use { 'github/copilot.vim' }
    use { 
      "zbirenbaum/copilot.lua",
      event = "InsertEnter",
      config = function () 
        vim.schedule(function()
          require("copilot").setup({
            suggestion = { enabled = false },
            panel = { enabled = false },
          })
        end)
      end
    }
    use {
      "zbirenbaum/copilot-cmp",
      after = { "copilot.lua", 'lspkind.nvim' },
      config = function ()
        require("copilot_cmp").setup()
        -- local lspkind = require("lspkind")
        -- lspkind.init({
        --   symbol_map = {
        --     Copilot = "",
        --   },
        -- })

        -- vim.api.nvim_set_hl(0, "CmpItemKindCopilot", {fg ="#6CC644"})
      end
    }
  end



  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
