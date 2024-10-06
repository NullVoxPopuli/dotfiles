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
    end,
  }

  -- Multi-cursor
  -- Some vim zealots really hate that people want this.
  -- They're wrong.
  -- Multi-cursor is good.
  -- Macros are also good, but not for the same purpose.
  use {
    -- This also effectively disables usage of the arrow key
    -- for normal movement. Should be using better movement anyway
    -- (by word, or hoppin')
    'jake-stewart/multicursor.nvim',
    branch = "1.0",
    config = function()
      local mc = require("multicursor-nvim")

      mc.setup()

      local set = vim.keymap.set

      -- Easy way to add and remove cursors using the main cursor.
      set({ "n", "v" }, "<c-q>", mc.toggleCursor)

      -- Delete the main cursor.
      set({ "n", "v" }, "<leader>x", mc.deleteCursor)

      -- bring back cursors if you accidentally clear them
      set("n", "<leader>gv", mc.restoreCursors)

      -- Add or skip cursor above/below the main cursor.
      set({ "n", "v" }, "<up>", function() mc.lineAddCursor(-1) end)
      set({ "n", "v" }, "<down>", function() mc.lineAddCursor(1) end)
      set({ "n", "v" }, "<leader><up>", function() mc.lineSkipCursor(-1) end)
      set({ "n", "v" }, "<leader><down>", function() mc.lineSkipCursor(1) end)

      -- Add or skip adding a new cursor by matching word/selection
      set({ "n", "v" }, "<leader>b", function() mc.matchAddCursor(1) end, { noremap = true })
      set({ "n", "v" }, "<leader>B", function() mc.matchAddCursor(-1) end)
      set({ "n", "v" }, "<leader>s", function() mc.matchSkipCursor(1) end)
      set({ "n", "v" }, "<leader>S", function() mc.matchSkipCursor(-1) end)

      -- Add all matches in the document
      set({ "n", "v" }, "<leader>A", mc.matchAllAddCursors)

      -- Rotate the main cursor.
      set({ "n", "v" }, "<left>", mc.nextCursor)
      set({ "n", "v" }, "<right>", mc.prevCursor)

      set("n", "<esc>", function()
        if not mc.cursorsEnabled() then
          mc.enableCursors()
        elseif mc.hasCursors() then
          mc.clearCursors()
        else
          -- Default <esc> handler.
        end
      end)

      -- Rotate visual selection contents.
      set("v", "<leader>t",
        function() mc.transposeCursors(1) end)
      set("v", "<leader>T",
        function() mc.transposeCursors(-1) end)
    end
  }

  -- Making up for issues in some tree-sitter grammars
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
