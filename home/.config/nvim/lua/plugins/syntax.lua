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
    config = function()
      require('nvim-ts-autotag').setup({
        opts = {
          -- Defaults
          enable_close = true,          -- Auto close tags
          enable_rename = true,         -- Auto rename pairs of tags
          enable_close_on_slash = false -- Auto close on trailing </
        },
        -- Also override individual filetype configs, these take priority.
        -- Empty by default, useful if one of the "opts" global settings
        -- doesn't work well in a specific filetype
        per_filetype = {
          -- ["html"] = {
          --   enable_close = false
          -- }
        },
      })
    end,
  }

  use {
    -- NOTE: this repo is working on a breaking change.
    --       it's pretty big and can't be tried out right now.
    --       a bunch of other plugins break.
    --
    --       (main is also super buggy right now)
    'nvim-treesitter/nvim-treesitter',
    branch = "main",
    config = function()
      require('nvim-treesitter').install({
        -- Many handled by ember.nvim
        -- Web Framework Languages
        "svelte",
        -- Web Transport Languages
        "graphql",
        -- "help", -- missing?
        -- "comment", -- slow?
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
      })

      vim.api.nvim_create_autocmd('FileType', {
        pattern = {
          'markdown',
          'scss',
          'jq', 'bash', 'c', 'go', 'rust', 'diff',
          'svelte', 'graphql', 'toml', 'yaml', 'dockerfile',
        },
        callback = function()
          -- Folding
          vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
          vim.wo[0][0].foldmethod = 'expr'

          -- indentation
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

          -- Fancy!
          vim.treesitter.start()
        end,
      })

      require("nvim-treesitter.install").prefer_git = true

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
