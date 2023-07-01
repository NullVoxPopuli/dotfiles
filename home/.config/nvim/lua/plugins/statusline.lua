return function(use)
  use {
    'nvim-lualine/lualine.nvim',
    -- 'NullVoxPopuli/lualine.nvim',
    -- branch = 'fix-filename-width',
    config = function ()

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
          lualine_a = { {'mode', upper = true} },
          lualine_b = { {'branch', icon = ''}, {'diff'} },
          -- lualine_b = { {'diff'} },
          lualine_c = { {'filename', file_status = true, path = 1 } },
          lualine_x = { 'filetype' },
          lualine_y = { 'progress' },
          lualine_z = { 'location'  },
        },
        inactive_sections = {
          lualine_a = {  },
          -- lualine_b = {  },
          lualine_b = { {'branch', icon = ''} },
         lualine_c = { {'filename', file_status = true, path = 1 } },
          lualine_x = {  },
          lualine_y = {  },
          lualine_z = {  }
        },
      }

    end
  }

  -- filename in top-right
  -- use { 
  --   "b0o/incline.nvim" ,
  --   config = function () 
  --     require('incline').setup({
  --       window = {
  --         padding = 2,
  --         margin = { horizontal = 2 },
  --         -- looks weird when there is no status
  --         -- options = { signcolumn = "yes" }
  --       },
  --     }) 
  --   end
  -- }

  -- winbar with great defaults
  use('Bekaboo/dropbar.nvim')
end
