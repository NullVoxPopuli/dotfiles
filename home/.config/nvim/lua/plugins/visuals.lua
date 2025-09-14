local function scrollbar(use)
  -- https://github.com/lewis6991/satellite.nvim
  use {
    'lewis6991/satellite.nvim',
    config = function()
      require('satellite').setup()
    end
  }
end

return function(use)
  ----------------------
  -- Greeting
  ----------------------
  use {
    'goolord/alpha-nvim',
    requires = { 'nvim-tree/nvim-web-devicons' },
    -- from
    -- https://github.com/cpow/neovim-for-newbs/blob/main/lua/plugins/alpha.lua
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")

      dashboard.section.header.val = {
        [[                                                                       ]],
        [[                                                                       ]],
        [[                                                                       ]],
        [[                                                                       ]],
        [[                                                                       ]],
        [[                                                                       ]],
        [[                                                                       ]],
        [[                                                                     ]],
        [[       ████ ██████           █████      ██                     ]],
        [[      ███████████             █████                             ]],
        [[      █████████ ███████████████████ ███   ███████████   ]],
        [[     █████████  ███    █████████████ █████ ██████████████   ]],
        [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
        [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
        [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
        [[                                                                       ]],
        [[                                                                       ]],
        [[                                                                       ]],
      }

      _Gopts = {
        position = "center",
        hl = "Type",
        -- wrap = "overflow";
      }

      local function footer()
        return "Haskell can suck mo' nads"
      end

      dashboard.section.footer.val = footer()

      dashboard.opts.opts.noautocmd = true
      alpha.setup(dashboard.opts)
    end
  }


  ----------------------
  -- Syntax / Theme
  ----------------------
  -- use 'joshdick/onedark.vim'
  use 'sainnhe/edge'

  -- UI
  use 'stevearc/dressing.nvim'

  ----------------------
  -- Information
  ----------------------
  scrollbar(use)

  -- Debounced / low-resource git-sign column integration
  -- Provides blame via line via <leader>gb (custom in keymap.vim)
  --
  -- See: https://github.com/lewis6991/gitsigns.nvim#comparison-with-vim-gitgutter
  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end
  }
  -- Indentation indication
  use {
    "lukas-reineke/indent-blankline.nvim",
  }
  -- colorize various color-like tokens in code
  use {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require 'colorizer'.setup()
    end
  }

  -- active-buffer highlight
  use {
    "nvim-zh/colorful-winsep.nvim",
    config = function()
      require('colorful-winsep').setup({
        border = { "─", "│", "╭", "╮", "╰", "╯" },
        animate = {
          enabled = "shift",
          shift = {
            deltay_time = 0,
            smooth_speed = 3,
          }
        }
      })
    end
  }
end
