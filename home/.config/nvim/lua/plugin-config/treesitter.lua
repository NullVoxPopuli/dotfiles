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

