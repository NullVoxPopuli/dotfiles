return function(use)
  use 'neovim/nvim-lspconfig'
  -- use '~/Development/NullVoxPopuli/nvim-lspconfig'
  -- use { 'muziejus/nvim-lspconfig', branch = "glint" }
  use 'williamboman/nvim-lsp-installer'

  -- Completion and sources for completion
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  -- It bothers me that this person's name is all caps
  use 'L3MON4D3/LuaSnip'

  -- https://github.com/arkav/lualine-lsp-progress
  -- Plugin for lualine
  -- use 'arkav/lualine-lsp-progress'
end
