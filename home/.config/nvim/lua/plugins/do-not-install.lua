-- Not very efficient.
-- copilot.lua explains why to use the
-- lua version over GitHub's own plugin
-- use { 'github/copilot.vim' }
--
-- Copilot in general is a bit buggy, and constantly can't find the node version
--
-- Login with :Copilot auth
use {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  config = function()
    require("copilot").setup({
      suggestion = { enabled = false },
      panel = { enabled = false },
    })
  end
}
use {
  "zbirenbaum/copilot-cmp",
  after = { "copilot.lua", 'lspkind.nvim' },
  config = function()
    -- https://github.com/orgs/community/discussions/16298
    -- vim.g.copilot_node_command = "~/.volta/bin/node"

    require("copilot_cmp").setup()
    local lspkind = require("lspkind")
    lspkind.init({
      symbol_map = {
        Copilot = "",
      },
    })

    vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
  end
}
