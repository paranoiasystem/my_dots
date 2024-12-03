## Required software

- zsh
- alacritty
- nvim
- tmux
- stow
- ripgrep
- asdf
- direnv
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
