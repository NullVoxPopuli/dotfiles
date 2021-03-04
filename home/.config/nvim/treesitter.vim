lua << EOF

require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true
  },
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false -- Whether the query persists across vim sessions
  }
}

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

EOF

if $GLIMMER_DEBUG == 'true'
  silent !mkdir -p ~/Development/OpenSource/
  silent !git clone git@github.com:alexlafroscia/tree-sitter-glimmer.git ~/Development/OpenSource/tree-sitter-glimmer
  silent !(cd ~/Development/OpenSource/tree-sitter-glimmer && git pull)
  silent !mkdir -p ~/.config/nvim/queries/glimmer
  silent !ln -s ~/Development/OpenSource/tree-sitter-glimmer/queries/highlights.scm ~/.config/nvim/queries/glimmer
endif
