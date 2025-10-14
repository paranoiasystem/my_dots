# my_dots :wrench:

## Required software

- zsh
- alacritty [https://alacritty.org/index.html](https://alacritty.org/index.html)
- nvim `brew install neovim`
- tmux `brew install tmux`
- stow `brew install stow`
- ripgrep `brew install ripgrep`
- fzf `brew install fzf`
- mise [https://mise.jdx.dev/](https://mise.jdx.dev/)

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
