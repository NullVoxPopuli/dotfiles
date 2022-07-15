local dvorak_keys = "aoeuidhtnsgcrld;qjkxbmwv"

return function(use)
  use {
    "folke/which-key.nvim",
    config = function()
      -- https://github.com/folke/which-key.nvim
      require("which-key").setup {
        plugins = {
          marks = false, -- shows a list of your marks on ' and `
          registers = false, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
          presets = {
            operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
            motions = true, -- adds help for motions
            text_objects = true, -- help for text objects triggered after entering an operator
          },
        },
      }
    end
  }

  -- Very fast motion
  use 'ggandor/lightspeed.nvim'

  use {
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      local tree_cb = require'nvim-tree.config'.nvim_tree_callback

      -- https://github.com/kyazdani42/nvim-tree.lua/blob/master/doc/nvim-tree-lua.txt#L505
      require'nvim-tree'.setup {
        open_on_setup = false,
        open_on_tab = false,

        filters = {
          custom = { '.git/', 'node_modules', '.cache', 'dist', 'tmp', 'declarations' }
        },

        diagnostics = {
          -- lsp info
          enable = true,
        },

        view = {
          width = 40,
          mappings = {
            list = {
              { key = "<Tab>", cb = tree_cb("preview") }
            }
          }
        },


        renderer = {
          indent_markers = {
            enable = true
          },
          icons = {
            show = {
              folder_arrow = false
            }
          }
        },

        actions = {
          open_file = {
            window_picker = {
              chars = dvorak_keys
            }
          }
        }

      }
    end
  }

end
