return function(use)
  vim.lsp.inline_completion.enable()

  -- use {
  --   "folke/sidekick.nvim",
  --   config = function()
  --     require("sidekick").setup({
  --       -- NOTE: requires 'copilot' to work (or other CLIs) -- and these require install scripts, which I refuse to enable
  --     })
  --   end
  -- }

  -- This is broken again
  -- Login via :Codeium Auth
  -- use {
  --   "Exafunction/windsurf.nvim",
  --   requires = {
  --     "nvim-lua/plenary.nvim",
  --     "hrsh7th/nvim-cmp",
  --   },
  --   config = function()
  --     -- if os.getenv('PWD'):find('Work') then
  --     --   -- Not yet approved for work
  --     -- else
  --     require("codeium").setup({
  --       enable_cmp_source = false,
  --       -- requires api.host, and I don't know what that is
  --       -- enterprise_mode = true,
  --       virtual_text = {
  --         enabled = true,
  --         idle_delay = 200,
  --       },
  --       map_keys = false,
  --     })
  --
  --     local accept = require('codeium.virtual_text').accept
  --
  --     -- On Dvorak, this is easy
  --     vim.keymap.set("i", "<C-u>", accept, { silent = true, expr = true, script = true, nowait = true })
  --     -- end
  --   end
  -- }
end
