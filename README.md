# my_dots :wrench:

## Required software

- zsh
- alacritty [https://alacritty.org/index.html](https://alacritty.org/index.html)
- nvim `brew install neovim`
- tmux `brew install tmux`
- stow `brew install stow`
- ripgrep `brew install ripgrep`
- fzf `brew install fzf`
- asdf [https://github.com/asdf-vm/asdf](https://github.com/asdf-vm/asdf)
- direnv [https://github.com/asdf-community/asdf-direnv](https://github.com/asdf-community/asdf-direnv)
- node

## Install

- install required software
- clone this repo
- move in the repo directory
- run this:

```sh

mkdir -p ~/.config
rm ~/.zshenv
stow . --target=$HOME
```
