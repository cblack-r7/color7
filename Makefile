all: gnome

check:
	@shellcheck -s sh ./generate.sh

package: check
	@tar cvzf color7.tar.gz templates/*

xfce:
	@install -D ./xfce4-terminal/*.theme $(HOME)/.local/share/xfce4/terminal/colorschemes

gnome:
	@./gnome-terminal/color7.sh
	@./gnome-terminal/color7-light.sh
	@./gnome-terminal/color7-pastel.sh

omzsh:
	@install -D ./oh-my-zsh/color7.zsh-theme $(HOME)/.oh-my-zsh/themes

install: xfce gnome omzsh

clean:
	@printf "Not really relevant\n"

.PHONY:
	all install clean xfce gnome omzsh check package
