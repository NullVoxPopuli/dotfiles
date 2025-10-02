return function(use)
  use "rafamadriz/friendly-snippets"
  -- https://github.com/ember-tooling/snippets/tree/neovim/main
  use { "ember-tooling/snippets", branch = "neovim/main" }
  use { "L3MON4D3/LuaSnip", tag = "v2.*" }

  -- For testing out local snippets
  -- use({
  --   "L3MON4D3/LuaSnip",
  --   tag = "v2.*",
  --   config = function()
  --   local home = os.getenv('HOME');
  --   -- local snippets = home .. '/.config/nvim/snippets'
  --   -- local ember = home .. '/Development/NullVoxPopuli/snippets'
  --
  --   require("luasnip.loaders.from_vscode").lazy_load {
  --     paths = { snippets },
  --   }
  --   end
  -- })

  -- Snippet editing
  -- use {
  --   "chrisgrieser/nvim-scissors",
  --   dependencies = { "nvim-telescope/telescope.nvim", "garymjr/nvim-snippets" },
  --   config = function()
  --     local home = os.getenv('HOME');
  --     -- local snippets = home .. '/.config/nvim/snippets'
  --     -- local ember = home .. '/Development/NullVoxPopuli/snippets'
  --
  --     require("scissors").setup {
  --       snippetDir = ember,
  --     }
  --   end,
  -- }
end
