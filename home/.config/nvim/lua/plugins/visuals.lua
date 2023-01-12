local function scrollbar(use)
  -- Choose this one or the following
  -- https://github.com/petertriho/nvim-scrollbar
  -- use {
  --   'petertriho/nvim-scrollbar',
  --   config = function()
  --     require('scrollbar').setup({
  --       hide_if_all_visible = false
  --     })
  --   end
  -- }

  -- Choose this one or the above
  -- https://github.com/lewis6991/satellite.nvim
  use {
    'lewis6991/satellite.nvim',
    config = function()
      require('satellite').setup()
    end
  }
end

return function (use)
  ----------------------
  -- Syntax / Theme
  ----------------------
  -- use 'joshdick/onedark.vim'
  use 'sainnhe/edge'

  -- UI
  use 'stevearc/dressing.nvim'
  use {
    -- greeting
    'goolord/alpha-nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
  }

  ----------------------
  -- Information
  ----------------------
  scrollbar(use)

  use 'airblade/vim-gitgutter'
  -- Indentation indication
  use "lukas-reineke/indent-blankline.nvim"
  -- colorize various color-like tokens in code
  use 'norcalli/nvim-colorizer.lua'
  -- tree-sitter plugin, colorizez brackets and parens
  use 'p00f/nvim-ts-rainbow'

  -- https://github.com/emileferreira/nvim-strict
  -- highlights potential codesmells
  -- don't use this, as it breaks JSON files.

end
