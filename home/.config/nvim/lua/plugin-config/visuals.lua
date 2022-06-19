-- https://github.com/lukas-reineke/indent-blankline.nvim
vim.cmd [[highlight IndentBlanklineIndent1 guibg=#252537 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent2 guibg=#202230 gui=nocombine]]

require("indent_blankline").setup {
  char = "",
  char_highlight_list = {
    "IndentBlanklineIndent1",
    "IndentBlanklineIndent2",
  },
  space_char_highlight_list = {
    "IndentBlanklineIndent1",
    "IndentBlanklineIndent2",
  },
  show_trailing_blankline_indent = false,
}
