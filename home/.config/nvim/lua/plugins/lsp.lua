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
      require('conform').setup({
        formatters_by_ft = {
          -- Use a sub-list to run only the first available formatter
          javascript = { "prettier", stop_after_first = true },
          ['javascript.glimmer'] = { "prettier", stop_after_first = true },
          typescript = { "prettier", stop_after_first = true },
          ['typescript.glimmer'] = { "prettier", stop_after_first = true },
          html = { "prettier", stop_after_first = true },
          ['html.edge'] = { "prettier", stop_after_first = true },
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
          --[[ prettierd = {
            require_cwd = true
          }, ]]
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
  use {
    "mhanberg/output-panel.nvim",
    version = "*",
    config = function()
      require("output_panel").setup({
        max_buffer_size = 5000 -- default
      })
    end,
  }
end
