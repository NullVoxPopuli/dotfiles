local dvorak_keys = "aoeuidhtnsgcrld;qjkxbmwv"

return function(use)
  use {
    'phaazon/hop.nvim',
    branch = 'v1', -- optional but strongly recommended
    config = function()
      -- you can configure Hop the way you like here; see :h hop-config
      require'hop'.setup { keys = dvorak_keys }
    end
  }

  use {
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    setup = function()
      vim.g.nvim_tree_highlight_opened_files = 0 -- breaks icon color
      vim.g.nvim_tree_add_trailing = 1
    end,
    config = function()
      local tree_cb = require'nvim-tree.config'.nvim_tree_callback

      -- https://github.com/kyazdani42/nvim-tree.lua/blob/master/doc/nvim-tree-lua.txt#L505
      require'nvim-tree'.setup {
        open_on_setup = false,
        open_on_tab = false,

        update_to_buf_dir = {
          enable = false,
          auto_open = false
        },

        filters = {
          custom = { '.git', 'node_modules', '.cache', 'dist', 'tmp', 'declarations' }
        },

        diagnostics = {
          -- lsp info
          enable = true,
        },

        view = {
          width = 40,
          auto_resize = true,
          mappings = {
            list = {
              { key = "<Tab>", cb = tree_cb("preview") }
            }
          }
        },

        renderer = {
          indent_markers = {
            enable = true
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
