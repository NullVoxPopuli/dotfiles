require('ufo').setup({
  open_fold_hl_timeout = 0,
  provider_selector = function(bufnr, filetype, buftype)
    return {'treesitter'}
  end
})

vim.o.foldcolumn = '0' -- '0' is not bad
vim.o.foldlevel = 20 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = -1
vim.o.foldenable = true
vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
vim.keymap.set('n', 'zr', require('ufo').openFoldsExceptKinds)
vim.keymap.set('n', 'zm', require('ufo').closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)
vim.keymap.set('n', 'z<space>', require('ufo').peekFoldedLinesUnderCursor)

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
  local glimmerRepo = "~/Development/NullVoxPopuli/tree-sitter-glimmer"

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
  local jsRepo = "~/Development/NullVoxPopuli/tree-sitter-javascript"

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
  local tsRepo = "~/Development/NullVoxPopuli/tree-sitter-typescript"

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

  local jsRepo = "~/Development/NullVoxPopuli/tree-sitter-javascript"
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

