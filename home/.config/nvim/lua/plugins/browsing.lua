local dvorak_keys = "aoeuidhtnsgcrld;qjkxbmwv"

return function(use)
  -- Very fast motion
  -- Hotkey 's' in normal mode
  use 'ggandor/lightspeed.nvim'

  -- This is a cool tool, but I ultimately don't use it
  -- use {
  --   "folke/which-key.nvim",
  --   config = function()
  --     -- https://github.com/folke/which-key.nvim
  --     require("which-key").setup {
  --       plugins = {
  --         marks = false, -- shows a list of your marks on ' and `
  --         registers = false, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
  --         presets = {
  --           operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
  --           motions = true, -- adds help for motions
  --           text_objects = true, -- help for text objects triggered after entering an operator
  --         },
  --       },
  --     }
  --   end
  -- }

  -- NOTE: nvim-tree.lua broke my trust via a rocky migration and breaking change.
  --       review their README very careful if re-evaluating.
  --
  --       neo-tree.nvim strives for avoiding breaking changes and still adhering to good UX
  vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

  use {
    "nvim-neo-tree/neo-tree.nvim",
      branch = "v3.x",
      requires = { 
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
      },
      config = function () 
        require('neo-tree').setup({
          default_component_configs = {
            name = { trailing_slash = true }
          },
          filesystem = {
            filtered_items = {
              visible = true,
              hide_dotfiles = false,
            },
          },
          buffers = { 
            follow_current_file = true
          },
        })
      end
    }

end
