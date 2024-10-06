local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
    install_path })
  print("Installing packer close and reopen Neovim...")
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
  require('plugins.git')(use)
  require('plugins.debugging')(use)
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
  use { 'vuki656/package-info.nvim', config = function()
    vim.api.nvim_set_keymap(
      'n', '<leader>v', '<cmd>lua require("package-info").show()<cr>',
      { silent = true, noremap = true }
    )
  end }

  ----------------------
  -- Editor Behavior
  ----------------------
  use 'tpope/vim-surround'

  use({ "L3MON4D3/LuaSnip", tag = "v2.*" })
  -- Snippet editing

  use {
    "chrisgrieser/nvim-scissors",
    dependencies = { "nvim-telescope/telescope.nvim", "garymjr/nvim-snippets" },
    config = function()
      local home = os.getenv('HOME');
      local snippets = home .. '/.config/nvim/snippets'

      require("scissors").setup {
        snippetDir = snippets,
      }
      require("luasnip.loaders.from_vscode").lazy_load {
        paths = { snippets },
      }


      vim.keymap.set("n", "<leader>se", function() require("scissors").editSnippet() end)

      -- when used in visual mode, prefills the selection as snippet body
      vim.keymap.set({ "n", "x" }, "<leader>sa", function() require("scissors").addNewSnippet() end)
    end,
  }

  use {
    'vidocqh/auto-indent.nvim',
    config = function()
      require("auto-indent").setup({
        -- Lightmode assumes tabstop and indentexpr not change within buffer's lifetime
        lightmode = true,
        -- Use vim.bo.indentexpr by default, see 'Custom Indent Evaluate Method'
        indentexpr = function(lnum)
          return require("nvim-treesitter.indent").get_indent(lnum)
        end,
        -- Disable plugin for specific filetypes, e.g. ignore_filetype = { 'javascript' }
        ignore_filetype = {},
      })
    end
  }
  use { "OlegGulevskyy/better-ts-errors.nvim",
    config = function()
      require("better-ts-errors").setup({
        keymap = '<leader>e' -- Toggling keymap
      })
    end
  }
  -- temporary
  -- use 'alvan/vim-closetag'

  -- Markdown
  use {
    'iamcco/markdown-preview.nvim',
    run = function() vim.fn["mkdp#util#install"]() end,
  }
  use {
    'abecodes/tabout.nvim',
    config = function()
      require('tabout').setup {}
    end,
    wants = { 'nvim-treesitter' }
  }

  -- Measure typing speed
  use {
    "jcdickinson/wpm.nvim",
    config = function()
      require("wpm").setup({
      })
    end
  }

  --  ¯\_( ツ )_/¯
  if os.getenv("COPILOT") == "true" then
    -- Login via :Codeium Auth
    -- Crashes frequently with neovim updates
    -- use {
    --   "Exafunction/codeium.nvim",
    --   requires = {
    --     "nvim-lua/plenary.nvim",
    --     "hrsh7th/nvim-cmp",
    --   },
    --   config = function()
    --     require("codeium").setup({
    --     })
    --   end
    -- }
  end



  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end)
