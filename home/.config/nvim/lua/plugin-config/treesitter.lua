require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    -- "markdown",
    "javascript", "typescript", "glimmer", "tsx",
    "html", "jsdoc", "regex", "bash",
    "toml", "html", "json",
    "css", "lua"
  },
  highlight = {
    enable = true,
  },
  playground = {
    enable = false,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false -- Whether the query persists across vim sessions
  },
  query_linter = {
    enable = true,
    use_virtual_text = true,
    lint_events = {"BufWrite", "CursorHold"},
  },
}

-- This is quite buggy
--  - incorrect highlights
--  - no nested language highlighting
if vim.env.MARKDOWN == 'true' then
  local parser_config = require "nvim-treesitter.parsers".get_parser_configs()

  parser_config.markdown = {
    install_info = {
      url = "https://github.com/ikatyang/tree-sitter-markdown",
      files = { "src/parser.c", "src/scanner.cc" },
    }
  }
end

if vim.env.GLIMMER_DEBUG == 'true' then
  local parser_config = require "nvim-treesitter.parsers".get_parser_configs()

  parser_config.glimmer = {
    install_info = {
      url = "~/Development/OpenSource/tree-sitter-glimmer",
      files = {
        "src/parser.c",
        "src/scanner.c"
      }
    },
    filetype = "hbs",
    used_by = {
      "handlebars",
      "html.handlebars"
    }
  }
end

