return function (use)
  ----------------------
  -- Syntax / Theme
  ----------------------
  -- use 'joshdick/onedark.vim'
  use 'sainnhe/edge'

  -- UI
  use 'stevearc/dressing.nvim'
  use { -- greeting
    'goolord/alpha-nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function ()
      local theta = require("alpha.themes.theta")
      local layout = theta.config.layout

      local config = {
        layout = {
          layout[0],
          layout[1],
          layout[2],
          layout[3],
          layout[4]
        },
        opts = theta.config.opts
      }

      require'alpha'.setup(config)
    end
  }

  ----------------------
  -- Information
  ----------------------
  use 'airblade/vim-gitgutter'
  -- Indentation indication
  use "lukas-reineke/indent-blankline.nvim"
  -- colorize various color-like tokens in code
  use 'norcalli/nvim-colorizer.lua'
  -- tree-sitter plugin, colorizez brackets and parens
  use 'p00f/nvim-ts-rainbow'

end
