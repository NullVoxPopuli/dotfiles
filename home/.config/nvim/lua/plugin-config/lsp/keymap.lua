-- Used in server.setup on_attach
local function keymap(bufnr)
  local function n(key, line)
    vim.keymap.set('n', key, '<cmd>lua ' .. line .. '<CR>', {
      buffer = bufnr,
      noremap = true,
      silent = true
    })
  end

  n('<leader>ff', 'vim.lsp.buf.format({ async = true })')

  n('<leader>u', 'vim.lsp.buf.signature_help({ border = "rounded" })')
  n('<leader>e', 'vim.diagnostic.open_float({ border = "rounded" })')
  n('<leader><Space>', 'vim.lsp.buf.hover({ border = "rounded" })')
  n('<leader>a', 'vim.lsp.buf.code_action()')
  n('<leader>rn', 'vim.lsp.buf.rename()')
end

vim.keymap.set("n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>")
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    keymap(args.buf)
  end
})
