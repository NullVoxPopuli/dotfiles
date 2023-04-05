local cmp = require('cmp')
local lspkind = require('lspkind')

-- https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance#menu-type
-- for later ^
cmp.setup({
  -- Disable completion in comments
  -- https://github.com/hrsh7th/nvim-cmp/wiki/Advanced-techniques#disabling-completion-in-certain-contexts-such-as-comments
  enabled = function()
    local context = require 'cmp.config.context'
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
    -- Selects next item in completion menu
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
          cmp.select_next_item()
        else
          fallback()
      end
    end,
    -- Selects previous item in completion menu
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'path' },
  }, {
    { name = 'nvim-cmp-ts-tag-close' },
    { name = 'copilot'},
    { name = 'nvim_lua' },
    { name = 'spell' },
  }, {
    { name = 'buffer' },
  }),
  formatting = {
    fields = {'menu', 'abbr', 'kind'},
    -- format = lspkind.cmp_format({
    --   symbol_map = { Copilot = "" }
    -- })
},
})

