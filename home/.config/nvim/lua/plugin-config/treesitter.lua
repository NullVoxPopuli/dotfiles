local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

parser_config.ejs = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-embedded-template",
    files = { "src/parser.c" },
    requires_generate_from_grammar = true,
  },
  filetype = "ejs",
}


if vim.env.GLIMMER_DEBUG == 'true' then
  local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
  local glimmerRepo = "~/Development/OpenSource/tree-sitter-glimmer"

  parser_config.glimmer = {
    install_info = {
      url = glimmerRepo,
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

  -- Resets the highlights
  -- vim.api.nvim_exec([[
  --   !rm -r ~/.config/nvim/queries/glimmer
  --   !mkdir -p ~/.config/nvim/queries/glimmer
  --   !ln -s ]] .. glimmerRepo .. [['/queries/*.scm ~/.config/nvim/queries/glimmer/
  -- ]], true)

  vim.cmd([[
    function UpdateAndNotify()
      :TSUpdate glimmer
      :echo 'Glimmer syntax debugging ready.'
    endfunction
    augroup GlimmerDebug
      autocmd!
      autocmd BufEnter *.hbs,*.gts,*.gjs,*.ts,*.js :call UpdateAndNotify()
    augroup END
  ]])
end

if vim.env.JS_DEBUG == 'true' then
  local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
  local jsRepo = "~/Development/OpenSource/tree-sitter-javascript"

  parser_config.javascript = {
    install_info = {
      url = jsRepo,
      files = { "src/parser.c", "src/scanner.c" },
    },
    filetype = "js",
    used_by = {
      "javascript",
      "javascript.glimmer"
    }
  }

  -- Resets the highlights
  vim.api.nvim_exec([[
    !rm -r ~/.config/nvim/queries/javascript
    !mkdir -p ~/.config/nvim/queries/javascript
  ]], true)
  vim.api.nvim_exec("!ln -s " .. jsRepo .. "/queries/*.scm ~/.config/nvim/queries/javascript/", true)

  vim.cmd([[
    function JSUpdateAndNotify()
      :TSUpdateSync javascript
      :echo 'JavaScript syntax debugging ready.'
    endfunction
    augroup JSDebug
      autocmd!
      autocmd BufEnter *.gts,*.gjs,*.ts,*.js :call JSUpdateAndNotify()
    augroup END
  ]])
end

if vim.env.TS_DEBUG == 'true' then
  local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
  local tsRepo = "~/Development/OpenSource/tree-sitter-typescript"

  parser_config.typescript = {
    install_info = {
      url = tsRepo .. "/typescript",
      files = { "src/parser.c", "src/scanner.c" },
    },
  }

  -- Resets the highlights
  vim.api.nvim_exec([[
    !rm -r ~/.config/nvim/queries/typescript
    !mkdir -p ~/.config/nvim/queries/typescript
  ]], true)

  vim.api.nvim_exec("!ln -s " .. tsRepo .. "/queries/*.scm ~/.config/nvim/queries/typescript/", true)

  local jsRepo = "~/Development/OpenSource/tree-sitter-javascript"
  vim.api.nvim_exec("!ln -s " .. jsRepo .. "/queries/*.scm ~/.config/nvim/queries/typescript/", true)

  vim.cmd([[
    function TSUpdateAndNotify()
      :TSUpdate typescript
      :echo 'TypeScript syntax debugging ready.'
    endfunction
    augroup JSDebug
      autocmd!
      autocmd BufEnter *.gts,*.ts :call TSUpdateAndNotify()
    augroup END
  ]])
end
