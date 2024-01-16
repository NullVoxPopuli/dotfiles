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
  use 'tpope/vim-commentary'
  -- lazygit Slow? investigate
  -- use 'kdheepak/lazygit.nvim'
  use 'editorconfig/editorconfig-vim'
  use { "sindrets/diffview.nvim", config = function()
    local actions = require("diffview.actions")

    function hl(name, options)
      vim.api.nvim_set_hl(0, name, options)
    end

    -- Base colors from theme.vim
    local addedBg = "#202930"
    local removedBg = "#302230"
    local bg = "#202230"

    hl('DiffviewDiffAddAsDelete', { bg = removedBg })
    hl('DiffDelete', { bg = removedBg })
    hl('DiffviewDiffDelete', { bg = removedBg })
    hl('DiffAdd', { bg = addedBg })
    hl('DiffChange', { bg = bg })
    hl('DiffText', { bg = bg })

    require('diffview').setup({
      enhanced_diff_hl = true,
      hooks = {
        diff_buf_read = function(bufnr)
          -- Change local options in diff buffers
          -- vim.opt_local.wrap = false
          -- vim.opt_local.list = false
          -- vim.opt_local.colorcolumn = { 80 }

          -- default diff fill chars are *way* too visually noisy
          vim.opt.fillchars:append { diff = " " }
        end,
        -- diff_buf_win_enter = function(bufnr)
        -- end,
      },

      keymaps = {
        view = {
          -- override NeoTree shortcuts
          { "n", "<leader>\\", actions.focus_files, { desc = "Bring focus to the file panel" } },
          { "n", "<leader>/",  actions.focus_files, { desc = "Bring focus to the file panel" } },
        },
        diff1 = {
          -- Mappings in single window diff layouts
          { "n", "?", actions.help({ "view", "diff1" }), { desc = "Open the help panel" } },
        },
        diff2 = {
          -- Mappings in 2-way diff layouts
          { "n", "?", actions.help({ "view", "diff2" }), { desc = "Open the help panel" } },
        },
      }
    })
  end }
  use { 'FabijanZulj/blame.nvim', config = function()
    require('blame').setup({ virtual_style = "right_asign" })
  end }
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
  -- * for search forward
  -- # for search backwards
  use 'backdround/improved-search.nvim'
  use { 'dnlhc/glance.nvim', config = function()
    require('glance').setup({
      detached = true,
      border = {
        enable = true,
        top_char = "─",
        bottom_char = "─"
      }
    })
    vim.keymap.set('n', 'gd', '<CMD>Glance definitions<CR>')
    vim.keymap.set('n', 'gi', '<CMD>Glance implementations<CR>')
    vim.keymap.set('n', 'gt', '<CMD>Glance type_definitions<CR>')
    vim.keymap.set('n', 'gr', '<CMD>Glance references<CR>')
  end }

  -- temporary
  use 'alvan/vim-closetag'

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
  end



  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end)
