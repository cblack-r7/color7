all: check gen

gen:
	@./generate.sh

check:
	@shellcheck -s sh ./generate.sh

package: check gen
	@git archive --prefix=color7/ --format=tar -o color7.tar HEAD
	@gzip color7.tar

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
