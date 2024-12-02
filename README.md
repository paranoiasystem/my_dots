## Required software

-   zsh
-   alacritty
-   nvim
-   tmux

install:
-   clone this repo
-   move in the repo directory
-   run this:
```sh
mkdir -p ~/.config # Ensure this dir exist so we don't link to it
rm ~/.zshenv # If you care about this file just move it so we can link it
stow . --target=$HOME
```
