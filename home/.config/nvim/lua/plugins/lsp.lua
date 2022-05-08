return function(use)
  use 'neovim/nvim-lspconfig'
  use 'williamboman/nvim-lsp-installer'

  -- Development
  -- use '~/Development/NullVoxPopuli/nvim-lspconfig'
  -- use { 'muziejus/nvim-lspconfig', branch = "glint" }

  -- Completion
  use {
    'hrsh7th/nvim-cmp',
     requires = {
       -- Completion Sources
       'hrsh7th/cmp-nvim-lsp',
       'hrsh7th/cmp-buffer',
       'hrsh7th/cmp-path',
       'hrsh7th/cmp-nvim-lua',
       'f3fora/cmp-spell',

       -- It bothers me that this person's name is all caps
       'L3MON4D3/LuaSnip'
      }
    }


  -- https://github.com/arkav/lualine-lsp-progress
  -- Plugin for lualine
  -- use 'arkav/lualine-lsp-progress'
end
