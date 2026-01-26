----------------------
-- Testing
----------------------
return function(use)
  use {
    "nvim-neotest/neotest",
    requires = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      -- Adapters
      "marilari88/neotest-vitest",
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-vitest") {
            filter_dir = function(name, rel_path, root)
              return name ~= "node_modules"
            end,
          }
        }
      })
    end
  }
end
