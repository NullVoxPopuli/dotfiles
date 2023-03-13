
-- Change diagnostic symbols in the sign column (gutter)
-- https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization#change-diagnostic-symbols-in-the-sign-column-gutter
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.opt.spelllang = { 'en_us' }

vim.diagnostic.config({
  -- virtual text makes things pretty claustrophobic
  --  would be great to only turn on/off for certain diagnostics providers tho
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    show_header = false,
    source = true,
    border = 'rounded',
    -- So we can copy-paste errors to chat
    focusable = true,
  },
})

