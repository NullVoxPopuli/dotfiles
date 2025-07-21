return function(use)
  use { 'williamboman/mason.nvim' }
  use { 'williamboman/mason-lspconfig.nvim' }
  use {
    'neovim/nvim-lspconfig',
    requires = {
      -- It bothers me that this person's name is all caps
      'L3MON4D3/LuaSnip',
      { 'Saghen/blink.cmp', tag = 'v1.1.1' }
    },
  }

  use {
    'stevearc/conform.nvim',
    config = function()
      local config = { "prettier", stop_after_first = true }

      require('conform').setup({
        formatters_by_ft = {
          -- Use a sub-list to run only the first available formatter
          javascript = config,
          typescript = config,
          html = config,
          ['html.edge'] = config,
          ['javascript.glimmer'] = config,
          ['typescript.glimmer'] = config,
        },
        format_on_save = {
          timeout_ms = 1000,
          lsp_fallback = true,
        },
        notify_on_error = false,
        formatters = {
          -- We don't want to enable prettierd
          -- because it requires global installation, and then
          -- we can't even have projects without prettier
          -- NOTE: make sure prettier (and prettierd) are not installed globally
          prettier = {
            require_cwd = true
          }
        }
      })
    end
  }

  -- null-ls plugin
  use { 'davidmh/cspell.nvim' }

  use 'j-hui/fidget.nvim'

  use {
    "smjonas/inc-rename.nvim",
    config = function()
      -- Default: <leader>r
      require("inc_rename").setup()
    end,
  }

  -- Debugging language servers
  -- Disabled from always being on,
  -- because it's buggy and dies after a time
  -- use {
  --   "mhanberg/output-panel.nvim",
  --   version = "*",
  --   config = function()
  --     require("output_panel").setup({
  --       max_buffer_size = 5000 -- default
  --     })
  --   end,
  -- }
end
