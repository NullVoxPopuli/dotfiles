return function(use)
  -- icons
  use 'onsails/lspkind.nvim'
  -- server management and installation
  use 'neovim/nvim-lspconfig'
  use { 'williamboman/mason.nvim' }
  use { 'williamboman/mason-lspconfig.nvim' }

  -- LSP integration with things that are not LSP
  -- This provides a unified interface for various tools
  -- that otherwise would need custom implemenations of the LSP UIs
  use 'jose-elias-alvarez/null-ls.nvim'

  -- Development
  -- use '~/Development/NullVoxPopuli/nvim-lspconfig'
  -- use { 'muziejus/nvim-lspconfig', branch = "glint" }

  -- Completion
  use {
    'hrsh7th/nvim-cmp',
     requires = {
       -- Completion Sources
       'hrsh7th/cmp-nvim-lsp',
       -- Considered hacky (by the author)
       -- https://github.com/hrsh7th/cmp-nvim-lsp-signature-help/issues/12#issuecomment-1128820104
       -- 'hrsh7th/cmp-nvim-lsp-signature-help',
       'hrsh7th/cmp-buffer',
       'hrsh7th/cmp-path',
       'hrsh7th/cmp-nvim-lua',
       -- 'f3fora/cmp-spell',

       -- It bothers me that this person's name is all caps
       'L3MON4D3/LuaSnip'
      }
    }

  use 'ray-x/lsp_signature.nvim'


  -- LSP status on the bottom right as hint text.
  -- subtle.
  --  Better than:
  --    use 'arkav/lualine-lsp-progress'
  --    use 'nvim-lua/lsp-status.nvim'
  --    use 'doums/lsp_spinner.nvim'
  --
  --  In that, this works (and is unobtrusive visually, and to the config)
  use 'j-hui/fidget.nvim'

  use {
    "smjonas/inc-rename.nvim",
    config = function()
      -- Default: <leader>r
      require("inc_rename").setup()
    end,
  }
end
