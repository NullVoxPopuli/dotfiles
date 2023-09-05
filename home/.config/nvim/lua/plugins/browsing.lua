local dvorak_keys = "aoeuidhtnsgcrld;qjkxbmwv"

return function(use)
  -- Very fast motion
  -- Hotkey 's' in normal mode
  -- Note, lightspeed's successor, leap, does not work as good.
  --       there are a lot of issues around behavior, extra cursors, etc
  --       lots of extra config needed, too.
  use { 'ggandor/lightspeed.nvim', config = function () 
    require('lightspeed').setup({})
    end
  }

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
