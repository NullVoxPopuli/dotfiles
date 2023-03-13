---------------------------------------------------------
--
-- NULL LS is for hooking up non-LSP tools to the LSP UX
--
--
-- Be sure to :checkhealth to see if any underlying tools are missing
--
-- pnpm add --global eslint_d @fsouza/prettierd cspell typescript
--
---------------------------------------------------------
local null_ls = require('null-ls')
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- TODO: figure out how to wire up ember-template-lint
local lsp_formatting = function(bufnr)
    vim.lsp.buf.format({
        filter = function(client)
            -- apply whatever logic you want (in this example, we'll only use null-ls)
            return client.name == "null-ls"
        end,
        bufnr = bufnr,
    })
end

-- Format on save
-- https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Avoiding-LSP-formatting-conflicts#neovim-08
local on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
                lsp_formatting(bufnr)
            end,
        })
    end
end

null_ls.setup({
  sources = {
    -- ESlint, but faster (daemonized)
    -- Install eslint_d globally -- it'll defer to local eslint
    null_ls.builtins.diagnostics.eslint_d,
    null_ls.builtins.formatting.eslint_d.with({
      filetypes = { "javascript", "typescript", "javascript.glimmer", "typescript.glimmer" }
    }), 
    -- Same for prettier
    null_ls.builtins.formatting.prettierd.with({
      filetypes = { 
        "css", "json", "jsonc","javascript", "typescript",
        "javascript.glimmer", "typescript.glimmer",
        "handlebars"
      }
    }),

    null_ls.builtins.code_actions.gitsigns,
    null_ls.builtins.completion.luasnip,

    -- Spell check that has better tooling
    -- all stored locally
    -- https://github.com/streetsidesoftware/cspell
    null_ls.builtins.diagnostics.cspell.with({
      extra_args = { "--config", "~/.cspell.json" }
    }),
    null_ls.builtins.code_actions.cspell.with({
      extra_args = { "--config", "~/.cspell.json" }
    })
    -- null_ls.builtins.completion.spell,
  },
  on_attach = on_attach
})

