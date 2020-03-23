all: check gen

gen:
	@./generate.sh

check:
	@shellcheck -s sh ./generate.sh

package: check gen
	@cp -r output/ color7-output/
	@tar cvzf color7.tar.gz color7-output/*
	@rm -rf color7-output/

install_xfce: check gen
	@mkdir -p $(HOME)/.local/share/xfce4/terminal/colorschemes
	@install -D ./output/xfce4-terminal/*.theme $(HOME)/.local/share/xfce4/terminal/colorschemes

install_gnome: check gen
	@./output/gnome-terminal/color7.sh
	@./output/gnome-terminal/color7-light.sh
	@./output/gnome-terminal/color7-pastel.sh
	@./output/gnome-terminal/color7-dark.sh

install_omzsh:
	@install -D ./output/oh-my-zsh/color7.zsh-theme $(HOME)/.oh-my-zsh/themes

install: install_xfce install_gnome install_omzsh

clean:
	@rm -rf ./output

.PHONY:
	all install clean install_xfce install_gnome install_omzsh check package
