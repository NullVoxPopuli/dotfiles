return function(use)
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.x',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  --------------------------------------------------
  -- use { 'junegunn/fzf', run = './install --bin', }
  -- use {
  --   'ibhagwan/fzf-lua',
  --   requires = { 'kyazdani42/nvim-web-devicons' },
  -- }
  -- previously used fzf-lua, which is great,
  -- but fzf-lua is *only* great at searching quickly,
  -- fzf-lua is not designed to be relevant to working
  -- within a project as smart-open is.
  --------------------------------------------------
  use {
    "danielfalk/smart-open.nvim",
    config = function()
      local telescope = require('telescope')

      telescope.load_extension("smart_open")
      -- telescope.load_extension('fzy_native')
      telescope.setup({
        extensions = {
          smart_open = {
            cwd_only = true,
            ignore_patterns = {
              "*.git/*", "*/tmp/",
              "*/vendor/",
              "*/dist/*",  "*/declarations/*", "*/node_modules/*"
            }
          },
          -- fzy_native = {
          --   override_generic_sorter = false,
          --   override_file_sorter = true,
          -- }
        }
      })
    end,
    requires = {
      -- "nvim-telescope/telescope-fzy-native.nvim",
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

      })
    end
  }
end
