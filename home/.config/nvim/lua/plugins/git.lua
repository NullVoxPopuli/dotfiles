return function(use)
  -- lazygit Slow? investigate
  -- use 'kdheepak/lazygit.nvim'
  use 'editorconfig/editorconfig-vim'
  use { "sindrets/diffview.nvim", config = function()
    local actions = require("diffview.actions")

    function hl(name, options)
      vim.api.nvim_set_hl(0, name, options)
    end

    -- Base colors from theme.vim
    local addedBg = "#202930"
    local removedBg = "#302230"
    local bg = "#202230"

    hl('DiffviewDiffAddAsDelete', { bg = removedBg })
    hl('DiffDelete', { bg = removedBg })
    hl('DiffviewDiffDelete', { bg = removedBg })
    hl('DiffAdd', { bg = addedBg })
    hl('DiffChange', { bg = bg })
    hl('DiffText', { bg = bg })

    require('diffview').setup({
      enhanced_diff_hl = true,
      hooks = {
        diff_buf_read = function(bufnr)
          vim.lsp.stop_client(vim.lsp.get_clients())
          -- Change local options in diff buffers
          --
          -- vim.opt_local.wrap = false
          -- vim.opt_local.list = false
          -- vim.opt_local.colorcolumn = { 80 }

          -- default diff fill chars are *way* too visually noisy
          vim.opt.fillchars:append { diff = " " }
        end,
        -- diff_buf_win_enter = function(bufnr)
        -- end,
      },

      keymaps = {
        view = {
          -- override NeoTree shortcuts
          { "n", "<leader>\\", actions.focus_files, { desc = "Bring focus to the file panel" } },
          { "n", "<leader>/",  actions.focus_files, { desc = "Bring focus to the file panel" } },
        },
        diff1 = {
          -- Mappings in single window diff layouts
          { "n", "?", actions.help({ "view", "diff1" }), { desc = "Open the help panel" } },
        },
        diff2 = {
          -- Mappings in 2-way diff layouts
          { "n", "?", actions.help({ "view", "diff2" }), { desc = "Open the help panel" } },
        },
      }
    })
  end }

  use { 'FabijanZulj/blame.nvim', config = function()
    local window = require("blame.views.window_view")
    require('blame').setup({
      virtual_style = "right_asign",
      views = {
        default = window,
      },
    })
  end }
end
