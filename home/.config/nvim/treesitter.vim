if $GLIMMER_DEBUG == 'true'
  silent !mkdir -p ~/Development/OpenSource/
  silent !git clone git@github.com:alexlafroscia/tree-sitter-glimmer.git ~/Development/OpenSource/tree-sitter-glimmer
  silent !(cd ~/Development/OpenSource/tree-sitter-glimmer && git pull)
  silent !mkdir -p ~/.config/nvim/queries/glimmer
  silent !ln -s ~/Development/OpenSource/tree-sitter-glimmer/queries/highlights.scm ~/.config/nvim/queries/glimmer
  silent !rm ~/.local/share/nvim/plugged/nvim-treesitter/parser/glimmer.so
  silent !rm -rf ~/.local/share/nvim/plugged/nvim-treesitter/queries/glimmer
  autocmd BufEnter *.hbs TSUpdate glimmer <CR>
endif
