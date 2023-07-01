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

  -- Fun 
  -- https://github.com/letieu/hacker.nvim

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
  -- lazygit Slow? investigate
  -- use 'kdheepak/lazygit.nvim'
  use 'editorconfig/editorconfig-vim'

  -- Markdown
  use {
    'iamcco/markdown-preview.nvim',
    run = function () vim.fn["mkdp#util#install"]() end,
  }
  use {
    'abecodes/tabout.nvim',
    config = function()
      require('tabout').setup {}
    end,
    wants = { 'nvim-treesitter' }
  }

  --  ¯\_( ツ )_/¯
  if os.getenv("COPILOT") == "true" then
    -- Login via :Codeium Auth
    use {
        "jcdickinson/codeium.nvim",
        -- Using a fixed version here until
        -- https://github.com/jcdickinson/codeium.nvim/issues/70
        -- is resolved
        commit = "b1ff0d6c993e3d87a4362d2ccd6c660f7444599f",
        requires = {
            "nvim-lua/plenary.nvim",
            "hrsh7th/nvim-cmp",
        },
        config = function()
            require("codeium").setup({
            })
        end
    }
    -- Not very efficient.
    -- copilot.lua explains why to use the 
    -- lua version over GitHub's own plugin
    -- use { 'github/copilot.vim' }
    --
    -- Copilot in general is a bit buggy, and constantly can't find the node version
    --
    -- Login with :Copilot auth
    use { 
      "zbirenbaum/copilot.lua",
      cmd = "Copilot",
      event = "InsertEnter",
      config = function () 
        require("copilot").setup({
          suggestion = { enabled = false },
          panel = { enabled = false },
        })
      end
    }
    use {
      "zbirenbaum/copilot-cmp",
      after = { "copilot.lua", 'lspkind.nvim' },
      config = function ()
        -- https://github.com/orgs/community/discussions/16298
        vim.g.copilot_node_command = "~/.volta/bin/node"

        require("copilot_cmp").setup()
        local lspkind = require("lspkind")
        lspkind.init({
          symbol_map = {
            Copilot = "",
          },
        })

        vim.api.nvim_set_hl(0, "CmpItemKindCopilot", {fg ="#6CC644"})
      end
    }
  else
    -- This generally isn't needed when using lots of 
    -- copilot suggestions. Copilot will include the matched pair.
    -- SEE: https://github.com/zbirenbaum/copilot-cmp/issues/31
    use 'windwp/nvim-autopairs'
  end



  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
