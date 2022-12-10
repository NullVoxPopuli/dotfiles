-- Linters don't all have language server plugins,
-- otherwise I'd use the lsp integration
return function (use)
  use {
    'mhartington/formatter.nvim',
    config = function()
    -- Utilities for creating configurations
      local util = require "formatter.util"
      local prettierConfig = function()
        return {
          exe = "./node_modules/.bin/prettier",
          args = {"--stdin-filepath", vim.fn.shellescape(vim.api.nvim_buf_get_name(0)), "--single-quote"},
          stdin = true
        }
      end
      local eslintConfig =  function()
          return {
            exe = "./node_modules/.bin/eslint",
            args = {"--stdin","--stdin-filename", vim.api.nvim_buf_get_name(0) },
            stdin = true
          }
        end

      -- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
      require("formatter").setup {
        -- All formatter configurations are opt-in
        filetype = {
          -- lua = {function() return {exe = "lua-format", stdin = true} end},
          json = { prettierConfig },
          html = { prettierConfig },
          typescript = { prettierConfig, eslintConfig },
          javascript = { prettierConfig, eslintConfig },
          handlebars = { prettierConfig, eslintConfig },
          ['typescript.glimmer']  = { prettierConfig, eslintConfig },
          ['javascript.glimmer']  = { prettierConfig, eslintConfig },

          -- Use the special "*" filetype for defining formatter configurations on
          -- any filetype
          ["*"] = {
            -- "formatter.filetypes.any" defines default configurations for any
            -- filetype
            require("formatter.filetypes.any").remove_trailing_whitespace
          }
        }
      }
    end
  }

end
