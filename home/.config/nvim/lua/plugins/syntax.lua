----------------------
-- Syntax Highlighting
----------------------
return function(use)
  -- Better Folding
  --  I *used to* use nvim-ufo, but it was really buggy.
  --  It would randomly fold things I wasn't expecting.
  --  - search results
  --  - neo-tree folders
  --
  --  It would also regularly break.
  --  Now I just use treesitter for folding.



  -- autoclose and autorename tags
  use {
    'windwp/nvim-ts-autotag',
  }

  use {
    -- NOTE: this repo is working on a breaking change.
    --       it's pretty big and can't be tried out right now.
    --       a bunch of other plugins break.
    --
    --       (main is also super buggy right now)
    'nvim-treesitter/nvim-treesitter',
    -- for developing highlights
    -- '~/Development/OpenSource/nvim-treesitter',
    run = function()
      require("nvim-treesitter.install").prefer_git = true
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
    config = function()
      require("nvim-treesitter.install").prefer_git = true
      require 'nvim-treesitter.configs'.setup {
        autotag = {
          enable = true,
          filetypes = {
            "html",
            "javascript", "typescript",
            "typescript.glimmer", "javascript.glimmer",
            "javascriptreact", "typescriptreact",
            "markdown", "markdown_inline",
            "glimmer", "handlebars", "hbs", "svelte", "vue"
          }
        },
        ensure_installed = {
          -- Web Languages
          "javascript", "typescript",
          "html", "css", "regex",
          -- Web Framework Languages
          "glimmer", "glimmer_javascript", "glimmer_typescript",
          "svelte",
          -- Web Transport Languages
          "graphql",
          -- Documentation Languages
          "markdown", "markdown_inline",
          -- "help", -- missing?
          -- "comment", -- slow?
          "jsdoc",
          -- Configuration Languages
          "toml", "jsonc", "yaml",
          "dockerfile",
          "lua", "vim", "hyprlang",
          "hcl", "terraform",
          -- Scripting Languages
          "commonlisp",
          "bash",
          "jq",
          -- Languages I don't know how to categorize
          "ruby",
          -- Systems Languages
          "c", "cmake",
          "rust",
          "go",
          -- Specifically for the treesitter AST
          "query",
          -- Utility Syntaxes
          "diff",
          "jq",
          "git_rebase", "gitcommit", "gitignore"
        },
        ignore_install = {
          "json" -- jsonc is better
        },
        highlight = {
          enable = true,
        },
        indent = {
          enable = true
        },
      }

      require('ts_context_commentstring').setup({})
      vim.g.skip_ts_context_commentstring_module = true

      vim.treesitter.language.register('html', 'html.edge')

      vim.filetype.add({
        pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
      })
    end
  }

  -- Useful for large functions or in unfamiliar code
  use 'nvim-treesitter/nvim-treesitter-context'

  -- Comments in embedded languages via treesitter
  use { 'JoosepAlviste/nvim-ts-context-commentstring',
    config = function()
      require('ts_context_commentstring').setup {
        enable_autocmd = false,
      }
    end
  }
end
