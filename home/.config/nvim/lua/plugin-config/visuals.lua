-- https://github.com/lukas-reineke/indent-blankline.nvim
vim.cmd [[highlight IndentBlanklineIndent1 guibg=#252537 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent2 guibg=#202230 gui=nocombine]]

local highlight = {
  "RainbowViolet",
}
vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })

require("ibl").setup {
  scope = { highlight = highlight },
}
