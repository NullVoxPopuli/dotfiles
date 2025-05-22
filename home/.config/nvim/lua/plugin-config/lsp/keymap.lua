-- Used in server.setup on_attach
local function keymap(bufnr)
  -- Helpers, Utilities, etc. (lua -> vim apis are verbose)
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  local function n(key, line)
    vim.keymap.set('n', key, '<cmd>lua ' .. line .. '<CR>', {
      buffer = bufnr,
      noremap = true,
      silent = true
    })
  end


  -- buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Global keymaps (no-remap by default, cause... sanity)
  -- handled by Glance
  -- n('gD', 'vim.lsp.buf.declaration()')
  -- n('gd', 'vim.lsp.buf.definition()')
  -- n('gi', 'vim.lsp.buf.implementation()')
  -- n('gt', 'vim.lsp.buf.type_definition()')
  -- n('gr', 'vim.lsp.buf.references()')
  n('<leader>ff', 'vim.lsp.buf.format({ async = true })')

  n('<leader>u', 'vim.lsp.buf.signature_help({ border = "rounded" })')
  n('<leader>e', 'vim.diagnostic.open_float({ border = "rounded" })')
  n('<leader><Space>', 'vim.lsp.buf.hover({ border = "rounded" })')
  n('<leader>a', 'vim.lsp.buf.code_action()')
  n('<leader>rn', 'vim.lsp.buf.rename()')
end

vim.keymap.set("n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>")

return keymap
