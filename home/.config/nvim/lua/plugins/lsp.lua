return function(use)
  -- icons
  use 'onsails/lspkind.nvim'
  -- server management and installation
  use { 'williamboman/mason.nvim' }
  use { 'williamboman/mason-lspconfig.nvim' }
  use { 'neovim/nvim-lspconfig' }

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

  ---- Completion
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      -- Completion Sources
      'hrsh7th/cmp-nvim-lsp',
      -- Considered hacky (by the author)
      -- https://github.com/hrsh7th/cmp-nvim-lsp-signature-help/issues/12#issuecomment-1128820104
      -- 'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-buffer',
      -- Freezes the whole editor
      --  https://github.com/hrsh7th/cmp-path/issues/68#issuecomment-1704351464
      -- 'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lua',
      -- For Snippets
      'saadparwaiz1/cmp_luasnip',
      -- 'f3fora/cmp-spell',

      -- Auto-closing tag suggestions
      'buschco/nvim-cmp-ts-tag-close',

      -- It bothers me that this person's name is all caps
      'L3MON4D3/LuaSnip'
    },
  }

  use 'ray-x/lsp_signature.nvim'
  use 'j-hui/fidget.nvim'

  use {
    "smjonas/inc-rename.nvim",
    config = function()
      -- Default: <leader>r
      require("inc_rename").setup()
    end,
  }
end
