return function(use)
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.7',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-fzy-native.nvim'
    },
    config = function()
      require('telescope').load_extension('fzy_native')
    end
  }

  -- / for search
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


  use {
    "danielfalk/smart-open.nvim",
    branch = '0.2.x',
    config = function()
      local telescope = require('telescope')

      telescope.load_extension("smart_open")
      -- telescope.load_extension('fzy_native')
      telescope.setup({
        extensions = {
          smart_open = {
            cwd_only = true,
            max_unindexed = 50000,
            ignore_patterns = {
              "*.git/*", "*/tmp/",
              "*/vendor/",
              "*/dist/*", "*/declarations/*", "*/node_modules/*"
            }
          },
        }
      })
    end,
    requires = {
      "nvim-telescope/telescope.nvim",
      -- sudo apt install sqlite3 libsqlite3-dev
      "kkharji/sqlite.lua",
      "kyazdani42/nvim-web-devicons"
    }
  }


  -- Project-wide Search, Find&Replace, with Regex!
  use {
    'nvim-pack/nvim-spectre',
    config = function()
      require('spectre').setup({
        --[[ default = {
          find = {
            cmd = "ag",
            options = {}
          }
        } ]]
      })
    end
  }
end
