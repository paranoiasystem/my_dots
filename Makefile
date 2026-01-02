.PHONY: apply
apply:
	mkdir -p ~/.config
	rm -f ~/.zshenv
	stow . --target=$$HOME