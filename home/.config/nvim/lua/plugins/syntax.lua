----------------------
-- Syntax Highlighting
----------------------
return function(use)
  -- Better Folding
  use {'kevinhwang91/nvim-ufo', requires = 'kevinhwang91/promise-async'}

  -- for developing highlights
  use 'nvim-treesitter/playground' -- debugging / reporting bugs
  use {
    'nvim-treesitter/nvim-treesitter',
    config = function()
      require("nvim-treesitter.install").prefer_git = true
      require'nvim-treesitter.configs'.setup {
        context_commentstring = {
          enable = true,
        },
        ensure_installed = {
          -- Web Languages
          "javascript", "typescript",
          "html", "css", "regex",
          "ejs",
          -- Web Framework Languages
          "glimmer", "tsx", "svelte",
          -- Web Transport Languages
          "graphql",
          -- Documentation Languages
          "markdown", "markdown_inline",
          "help", "comment", "jsdoc",
          -- Configuration Languages
          "toml", "jsonc",
          "dockerfile",
          "lua", "vim",
          -- Scripting Languages
          "commonlisp",
          "bash",
          "jq",
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
        rainbow = {
          enable = true,
          extended_mode = true,
        },
        playground = {
          enable = false,
          disable = {},
          updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
          persist_queries = false, -- Whether the query persists across vim sessions
          keybindings = {
            toggle_query_editor = 'o',
            toggle_hl_groups = 'i',
            toggle_injected_languages = 't',
            toggle_anonymous_nodes = 'a',
            toggle_language_display = 'I',
            focus_language = 'f',
            unfocus_language = 'F',
            update = 'R',
            goto_node = '<cr>',
            show_help = '?',
          },
        }
      }
    end
  }

  -- Useful for large functions or in unfamiliar code
  use 'nvim-treesitter/nvim-treesitter-context'

  -- Comments in embedded languages via treesitter
  use 'JoosepAlviste/nvim-ts-context-commentstring'

  -- TreeSitter-aware spell checking
  -- not enabled for now, because there is yet to be a solidy LSP integration with spell
  -- use {
  --   'lewis6991/spellsitter.nvim',
  --   config = function()
  --     require('spellsitter').setup()
  --   end
  -- }
end
