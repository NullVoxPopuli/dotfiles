# dotfiles

All the linux configuration things I use.


## Tools

### IDE / Editor - neovim

Have to install from here, because apt is out of date.
https://github.com/neovim/neovim/releases/

NOTE: fzf needs ripgrep installed: https://github.com/BurntSushi/ripgrep#installation

### Application Launching - Albert

https://albertlauncher.github.io/

- emoji picker: https://softwarerecs.stackexchange.com/questions/67473/linux-emoji-input

### Benchmarking - Hyperfine

https://github.com/sharkdp/hyperfine

### File statistics - Tokei

https://github.com/XAMPPRocky/tokei

 - no need to install -- download, untar, drop in `~/Applications/`

### `ls`, but better

https://github.com/eza-community/eza

`sudo apt install eza`

### `cat`, but better

https://github.com/sharkdp/bat

`sudo apt install bat`

### `man`, but brief

https://tldr.sh/

- `volta install tldr`

### paths => tree

https://github.com/jez/as-tree

- no need to install -- download, unzip, drop in `~/Applications/`
- example: `ag -g sh -l | as-tree` (ie: `get-paths | as-tree`)


## Tools to evaluate / keep an eye on

- https://github.com/jesseduffield/lazygit
  - why don't they support ubuntu anymore?

- https://github.com/jonas/tig/releases
  - only manual install

- https://github.com/Wilfred/difftastic/releases
  - only manual install
  - perf issues
