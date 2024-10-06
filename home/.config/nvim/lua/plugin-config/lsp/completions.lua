local cmp = require('cmp')
local lspkind = require('lspkind')
local luasnip = require("luasnip")

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

-- https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance#menu-type
-- for later ^
cmp.setup({
  -- Disable completion in comments
  -- https://github.com/hrsh7th/nvim-cmp/wiki/Advanced-techniques#disabling-completion-in-certain-contexts-such-as-comments
  enabled = function()
    local context = require 'cmp.config.context'
    local buftype = vim.api.nvim_buf_get_option(0, "buftype")

    if buftype == "prompt" then return false end

    -- keep command mode completion enabled when cursor is in a comment
    if vim.api.nvim_get_mode().mode == 'c' then
      return true
    else
      return not context.in_treesitter_capture("comment")
          and not context.in_syntax_group("Comment")
    end
  end,
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  experimental = {
    ghost_text = true
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.complete(),

    -- Scroll up in docs -- only works when scrollbar is visible
    ['<C-k>'] = cmp.mapping.scroll_docs(-4),
    -- Scroll down in docs -- only works when scrollbar is visible
    ['<C-j>'] = cmp.mapping.scroll_docs(4),

    -- Same as the escape key
    ['<C-e>'] = cmp.mapping.abort(),
    -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.locally_jumpable(1) then
        luasnip.jump(1)
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = cmp.config.sources({
    { name = 'luasnip' },
    { name = 'nvim_lsp' },
    { name = 'path',    max_item_count = 3 },
  }, {
    { name = 'nvim-cmp-ts-tag-close' },
    { name = "codeium",              max_item_count = 3 },
    -- { name = 'copilot'},
    { name = 'nvim_lua' },
    { name = 'spell' },
  }, {
    { name = 'buffer', max_item_count = 3 },
  }),
  formatting = {
    fields = { 'menu', 'abbr', 'kind' },
    format = require('lspkind').cmp_format({
      mode = "symbol",
      maxwidth = 50,
      ellipsis_char = '...',
      symbol_map = {
        Codeium = " | Codeium",
        Copilot = " | Copilot"
      }
    })
  },
})
