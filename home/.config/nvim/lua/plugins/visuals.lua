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

  if not vim.g.neovide then
    use {
      -- greeting
      'goolord/alpha-nvim',
      requires = { 'kyazdani42/nvim-web-devicons' },
    }
  end

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
  use 'norcalli/nvim-colorizer.lua'
  -- tree-sitter colorizes ({[, etc 
  use { 
    'https://gitlab.com/HiPhish/rainbow-delimiters.nvim.git',
    config = function() 
      local rainbow_delimiters = require 'rainbow-delimiters'

      vim.g.rainbow_delimiters = {
          strategy = {
              [''] = rainbow_delimiters.strategy['global'],
              vim = rainbow_delimiters.strategy['local'],
          },
          query = {
              [''] = 'rainbow-delimiters',
              lua = 'rainbow-blocks',
          },
          highlight = {
              'RainbowDelimiterOutest',
              'RainbowDelimiterViolet',
              'RainbowDelimiterOrange',
              'RainbowDelimiterBlue',
              'RainbowDelimiterGreen',
              'RainbowDelimiterYellow',
              'RainbowDelimiterRed',
          },
      }
    end
  }

  -- https://github.com/emileferreira/nvim-strict
  -- highlights potential codesmells
  -- don't use this, as it breaks JSON files.

  -- active-buffer highlight
  use {
    "nvim-zh/colorful-winsep.nvim",
    config = function ()
      require('colorful-winsep').setup({
        highlight = {
          bg = "#202230",
          fg = "#a300de",
        },
        -- default
        -- symbols = { "━", "┃", "┏", "┓", "┗", "┛" },
        symbols = { "─", "│", "╭", "╮", "╰", "╯" },
      }) 
    end
  }

  -- Visual decorations around popovers and such
  -- kind of glitchy -- as if they use useEffect to apply their stuff
  -- use { 
  --   'folke/noice.nvim',
  --   requires = {
  --     'MunifTanjim/nui.nvim',
  --     'nvim-telescope/telescope.nvim',
  --   },
  --   config = function () 
  --     local telescope = require('telescope')

  --     require("telescope").load_extension("noice")

  --     require('noice').setup({
  --       lsp = {
  --         -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
  --         override = {
  --           ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
  --           ["vim.lsp.util.stylize_markdown"] = true,
  --           ["cmp.entry.get_documentation"] = true,
  --         },
  --       },
  --       cmdline = { view = "cmdline" },
  --     });
  --   end
  -- }
end
