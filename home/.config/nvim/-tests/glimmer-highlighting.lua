require('packer').startup(function(use)
  use {
    'nvim-treesitter/nvim-treesitter',
    config = function()
      require 'nvim-treesitter.configs'.setup {
        ensure_installed = {
          -- Web Languages
          "javascript", "typescript",
          "html", "css", "regex",
          -- Web Framework Languages
          "glimmer", "glimmer_javascript", "glimmer_typescript",
          "jsdoc",
          "diff",
        },
        highlight = {
          enable = true,
        },
        indent = {
          enable = true
        },
      }
    end
  }
end)
