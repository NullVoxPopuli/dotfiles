require('plugin-config.lsp')

vim.opt.list = true
vim.opt.listchars:append("space:⋅")
vim.opt.listchars:append("eol:↴")

require('indent_blankline').setup {
  char = "▏",
}
