return function(use)
  -- Very fast motion
  -- Hotkey 's' in normal mode
  -- Note, lightspeed's successor, leap, does not work as good.
  --       there are a lot of issues around behavior, extra cursors, etc
  --       lots of extra config needed, too.
  -- use { 'ggandor/lightspeed.nvim', config = function()
  --   require('lightspeed').setup({})
  -- end
  -- }
  use { 'smoka7/hop.nvim', config = function()
    local hop = require('hop')
    -- ts hopping is really bad in JSON (it's just one node haha)
    -- local hopTS = require('hop-treesitter')
    hop.setup({})

    vim.keymap.set('', 'f', function()
      hop.hint_words()
      -- hopTS.hint_nodes()
    end, { remap = true })
  end }

  -- Same thing as hop, but for buffers / panes
  use { 'NStefan002/wormhole.nvim', config = function()
    vim.keymap.set("n", "<M-f>", "<Plug>(WormholeLabelsToggle)", { desc = "Wormhole Labels Toggle" })
  end
  }

  -- This tool helps me learn plugins' custom
  -- use {
  --   "folke/which-key.nvim",
  --   config = function()
  --     -- NOTE: these settings affects all delay behavior
  --     vim.o.timeout = true
  --     vim.o.timeoutlen = 300
  --     require("which-key").setup {
  --       plugins = {
  --         presets = {
  --           operators = false,    -- adds help for operators like d, y, ...
  --           motions = false,      -- adds help for motions
  --           text_objects = false, -- help for text objects triggered after entering an operator
  --           windows = false,      -- default bindings on <c-w>
  --           nav = false,          -- misc bindings to work with windows
  --           z = true,             -- bindings for folds, spelling and others prefixed with z
  --           g = false,            -- bindings for prefixed with g
  --           c = true,
  --         },
  --       }
  --     }
  --   end
  -- }

  -- NOTE: nvim-tree.lua broke my trust via a rocky migration and breaking change.
  --       review their README very careful if re-evaluating.
  --
  --       neo-tree.nvim strives for avoiding breaking changes and still adhering to good UX
  vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

  use { 's1n7ax/nvim-window-picker', tag = 'v2.*' }
  use {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      "s1n7ax/nvim-window-picker"
    },
    config = function()
      require('neo-tree').setup({
        default_component_configs = {
          name = { trailing_slash = true }
        },
        filesystem = {
          filtered_items = {
            visible = true,
            hide_dotfiles = false,
            show_hidden_count = true,
            hide_by_pattern = { ".git", "node_modules" }
          },
        },
        buffers = {
          follow_current_file = {
            enabled = true
          }
        },
        window = {
          mappings = {
            ["<cr>"] = "open_with_window_picker"
          }
        }
      })
    end
  }
end
