---------------------------------------------------------
--
-- NULL LS is for hooking up non-LSP tools to the LSP UX
--
--
-- Be sure to :checkhealth to see if any underlying tools are missing
--
-- pnpm add --global @fsouza/prettierd cspell typescript
--
---------------------------------------------------------
local lsp = require('lspconfig')
local null_ls = require('null-ls')
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- TODO: figure out how to wire up ember-template-lint
local lsp_formatting = function(buffer)
  vim.lsp.buf.format({
    filter = function(client)
      -- By default, ignore any formatters provider by other LSPs 
      -- (such as those managed via lspconfig or mason)
      -- Also "eslint as a formatter" doesn't work :( 
      return client.name == "null-ls"
    end,
    bufnr = buffer,
  })
end

-- Format on save
-- https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Avoiding-LSP-formatting-conflicts#neovim-08
local on_attach = function(client, buffer)
  -- the Buffer will be null in buffers like nvim-tree or new unsaved files
  if (not buffer) then
    return
  end

  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = buffer })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = buffer,
      callback = function()
        lsp_formatting(buffer)
      end,
    })
  end
end

local cspell = require('cspell')
-- This file is symlinked from my dotfiles repo
local cspellConfigFile = os.getenv('HOME') .. '/.cspell.json'

local cspellConfig = {
  find_json = function()
    return cspellConfigFile
  end,
  --- Callback after a successful execution of a code action.
  ---@param cspell_config_file_path string|nil
  ---@param params GeneratorParams
  ---@action_name 'use_suggestion'|'add_to_json'|'add_to_dictionary'
  on_success = function(cspell_config_file_path, params, action_name)
      -- For example, you can format the cspell config file after you add a word
      if action_name == 'add_to_json' then
          os.execute(
              string.format(
                  "cat %s | jq -S '.words |= sort' | tee %s > /dev/null",
                  cspell_config_file_path,
                  cspell_config_file_path
              )
          )
      end

      -- Note: The cspell_config_file_path param could be nil for the
      -- 'use_suggestion' action
  end
}

null_ls.setup({
  sources = {
    -- Prettier, but faster (daemonized)
    null_ls.builtins.formatting.prettierd.with({
      filetypes = { 
        "css", "json", "jsonc","javascript", "typescript",
        "javascript.glimmer", "typescript.glimmer",
        "handlebars"
      },
      condition = function()
        -- return require('null-ls.utils').root_pattern( ".prettierrc.js", ".prettierrc.cjs")(vim.api.nvim_buf_get_name(0)) ~= nil
        return lsp.util.root_pattern( ".prettierrc.js", ".prettierrc.cjs")
      end,
      generator_opts = {
        cwd = function(params)
          return lsp.util.root_pattern( ".prettierrc.js", ".prettierrc.cjs")(params.bufname)
        end
      },

    }),

    -- Code actions for staging hunks, blame, etc 
    null_ls.builtins.code_actions.gitsigns,
    null_ls.builtins.completion.luasnip,

    cspell.diagnostics.with({ config = cspellConfig }),
    cspell.code_actions.with({ 
      config = cspellConfig,
      on_success = function(_)

        -- ❯ cat <<< $(jq -S '.words |= sort' ~/.cspell.json) > ~/.cspell.json

        -- local command = "cat <<< $(jq -S '.words |= sort' " .. cspellConfigFile .. ") > " .. cspellConfigFile 

        -- os.execute(command)
        os.execute("cat <<< $(jq -S '.words |= sort' ~/.cspell.json) > ~/.cspell.json")
    end,
    }),
    -- null_ls.builtins.completion.spell,
  },
  on_attach = on_attach
})

