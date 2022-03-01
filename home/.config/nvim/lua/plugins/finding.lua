return function(use) 
  use { 'junegunn/fzf', run = './install --bin', }
  use {
    'ibhagwan/fzf-lua',
    requires = { 'kyazdani42/nvim-web-devicons' },
  }

  -- Project-wide Search, Find&Replace, with Regex!
  use {
    'windwp/nvim-spectre',
    config = function()
      require('spectre').setup({

      })
    end
  }
end
