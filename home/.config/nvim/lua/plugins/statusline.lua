return function(use)
  use {
    'nvim-lualine/lualine.nvim',
    -- 'NullVoxPopuli/lualine.nvim',
    -- branch = 'fix-filename-width',
    config = function()
      local wpm = require("wpm")

      require('lualine').setup {

        options = {
          theme = 'dracula',
          -- theme = 'nightfly'
          -- these settings make the status line minimal
          -- component_separators = "",
          -- section_separators = "",
        },
        extensions = { 'fzf', 'nvim-tree' },

        sections = {
          lualine_a = { { 'mode', upper = true } },
          lualine_b = { { 'branch', icon = '' }, { 'diff' } },
          -- lualine_b = { {'diff'} },
          lualine_c = { { 'filename', file_status = true, path = 1 } },
          lualine_x = { 'filetype' },
          lualine_y = { 'progress', 'location' },
          lualine_z = { wpm.wpm, wpm.historic_graph },
        },
        inactive_sections = {
          lualine_a = {},
          -- lualine_b = {  },
          lualine_b = { { 'branch', icon = '' } },
          lualine_c = { { 'filename', file_status = true, path = 1 } },
          lualine_x = {},
          lualine_y = {},
          lualine_z = {}
        },
      }
    end
  }

  -- winbar with great defaults
  use {
    'Bekaboo/dropbar.nvim',
    requires = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("dropbar").setup({
        bar = {
          sources = function()
            local sources = require('dropbar.sources')
            return { sources.path }
          end
        }
      })
    end
  }
end
