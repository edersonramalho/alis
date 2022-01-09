#!/usr/bin/env bash
# 
# ---------------------------------------------------------------- #
# Script Name:   install_bspwm_arch.sh 
# Description:   Pós instalação do Arch Linux GUI (BSPWM).
# Site:          
# Linkedin:      
# Written by:    Ederson Santos
# Maintenance:   Ederson Santos
# ---------------------------------------------------------------- #
# Usage:         
#       $ ./install_bspwm_arch.sh
# ---------------------------------------------------------------- #
# History:       v1.0 31/12/2021, essantos:
#                - Inicio
#                - Definição dos programas
#                v1.1 , essantos:
#                - 
# -----------------------------------------------------------------#
# Thankfulness:
#
# -----------------------------------------------------------------#

#def

_BLACK=$(tput setaf 0)
_RED=$(tput setaf 1)
_GREEN=$(tput setaf 2)
_BLUE=$(tput setaf 4)
_BRANCO=$(tput setaf 7)
_RESET=$(tput sgr0)
_BOLD=$(tput bold)
_BR=$(tput setab 7)

#limpar tela

clear

#Titulo

echo "${_BOLD}${_BLACK}${_BR}"
echo "                                                                 "
echo "----------------[Pos Instalação Arch Linux (Gui)]----------------"
echo "                                                                 "
echo "${_RESET}"

# Variáveis

list_sys=(
	sddm
	picom
	polybar
	rofi
	gvfs
	thunar
	thunar-archive-plugin
	thunar-volman
	feh
	which
	sudo
	gparted
	grub-customizer
	clamav
	clamtk
	zsh
	efibootmgr
	gzip
	p7zip
	unzip
	htop
	gnome-disk-utility
	libnotify
	netctl
	networkmanager
	pavucontrol
	pulseaudio
	pulseaudio-alsa
	scrot
	wget
	wireless_tools
	git
	ctags
	ncurses
	curl
	qt5-quickcontrols2
	qt5-graphicaleffects
	qt5-svg
)

list_font=(
	ttf-inconsolata
	ttf-roboto	
	otf-font-awesome
)

list_dev=(
	git
	base-devel
	meld	
	git
	lazygit
	neovim
	python-pip
)

list=(
	libreoffice
	vlc
)

list_yay=(
	zeal
	nerd-fonts-complete
	nerd-fonts-roboto-mono
	ttf-font-awesome
	nordic-theme
	numix-icon-theme-git
	networkmanager-dmenu-bluetoothfix-git
	spotify
	visual-studio-code-bin
	gitahead
	bat-cat-git
)

list_kernel=(
	linux-lts
	linux-lts-headers
)

dthr="$(date '+%Y%m%d%H%M')"
arquivo_log="${dthr}_log.log"
path_download="$HOME/Downloads/IBA"
path_workspace="$HOME/workspace"
path_conf="$HOME/workspace/_conf"
path_pwd="$(pwd)"

#path_download CRIAR

if [ -d "$path_download" ];then
  # se o diretório existir
  touch "$path_download"/"$arquivo_log"  
else
  # se não existir, vai ser criado o diretório
  mkdir "$path_download"; 
  touch "$path_download"/"$arquivo_log"
fi

#path workspace ~/workspace/_conf/

if [ -d "$path_workspace" ];then
  # se o diretório existir
  if ! [ -d "$path_workspace/_conf" ];then
    mkdir "$path_workspace/_conf"
  fi
else
  # se não existir, vai ser criado o diretório
  mkdir "$path_workspace";
  mkdir "$path_workspace/_conf"
fi

# Function Install 

func_install() {
	if pacman -Qi $1 &> /dev/null; then
		echo ""
		echo "${_BOLD}${_GREEN}==>${_RESET}${_BOLD} [pacman] Pacote "$1" já instalado ${_RESET}"
	else
		echo ""
		echo "${_BOLD}${_GREEN}==>${_RESET}${_BOLD} [pacman] Pacote "$1" ${_RESET}"

    	sudo pacman -S --noconfirm --needed $1
    fi
}

# Function Install yay

func_install_yay() {
	if yay -Qi $1 &> /dev/null; then
		echo ""
		echo "${_BOLD}${_GREEN}==>${_RESET}${_BOLD} [yay] Pacote "$1" já instalado ${_RESET}"
	else
		echo ""
		echo "${_BOLD}${_GREEN}==>${_RESET}${_BOLD} [yay] Pacote "$1" ${_RESET}"

    	yay -S --noconfirm --needed $1
    fi
}

# CD

cd ${path_download}

# Atualização SO

echo "${_BOLD}${_GREEN}===>${_RESET}${_BOLD} Atualização do SO${_RESET}"

sudo pacman -Sy --noconfirm --needed 
sudo pacman -Su --noconfirm --needed 

# Atualização Kernel LTS

echo "${_BOLD}${_GREEN}===>${_RESET}${_BOLD} Instalação do Kernel LTS${_RESET}"

#sudo pacman -S --noconfirm --needed
count=0
for name in "${list_kernel[@]}" ; do
	count=$[count+1]	
	echo ""
	echo "${_BOLD}${_GREEN}>${_RESET}${_BOLD} Instalando pacote nº "$count" "$name" ${_RESET}"
	func_install $name
done
##sudo grub-mkconfig -o /boot/grub/grub.cfg
## pós install / reboot
## sudo pacman -R linux


echo ""
echo "${_BOLD}${_GREEN}====>${_RESET}${_BOLD} Instalação do pacotes ${_RESET}"

echo ""
echo "${_BOLD}${_GREEN}==>${_RESET}${_BOLD} SYS ${_RESET}"
count=0

for name in "${list_sys[@]}" ; do
	count=$[count+1]
	#tput setaf 3;echo "Installing package nr.  "$count " " $name;tput sgr0;
	echo ""
	echo "${_BOLD}${_GREEN}>${_RESET}${_BOLD} Instalando pacote nº "$count" "$name" ${_RESET}"
	func_install $name
done

echo ""
echo "${_BOLD}${_GREEN}==>${_RESET}${_BOLD} Fonts e Themes ${_RESET}"

count=0

for name in "${list_font[@]}" ; do
	count=$[count+1]
	#tput setaf 3;echo "Installing package nr.  "$count " " $name;tput sgr0;
	echo ""
	echo "${_BOLD}${_GREEN}>${_RESET}${_BOLD} Instalando pacote nº "$count" "$name" ${_RESET}"
	func_install $name
done

echo ""
echo "${_BOLD}${_GREEN}==>${_RESET}${_BOLD} Dev ${_RESET}"

count=0

for name in "${list_dev[@]}" ; do
	count=$[count+1]
	#tput setaf 3;echo "Installing package nr.  "$count " " $name;tput sgr0;
	echo ""
	echo "${_BOLD}${_GREEN}>${_RESET}${_BOLD} Instalando pacote nº "$count" "$name" ${_RESET}"
	func_install $name
done

echo ""
echo "${_BOLD}${_GREEN}==>${_RESET}${_BOLD} Outros ${_RESET}"

count=0
for name in "${list[@]}" ; do
	count=$[count+1]
	#tput setaf 3;echo "Installing package nr.  "$count " " $name;tput sgr0;
	echo ""
	echo "${_BOLD}${_GREEN}>${_RESET}${_BOLD} Instalando pacote nº "$count" "$name" ${_RESET}"
	func_install $name
done

echo ""
echo "${_BOLD}${_GREEN}====>${_RESET}${_BOLD} yay ${_RESET}"

#####
mkdir ${path_download}
cd ${path_download}
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ${path_download}
####

echo ""
echo "${_BOLD}${_GREEN}==>${_RESET}${_BOLD} Pacotes YAY ${_RESET}"

count=0
for name in "${list_yay[@]}" ; do
	count=$[count+1]
	#tput setaf 3;echo "Installing package nr.  "$count " " $name;tput sgr0;
	echo ""
	echo "${_BOLD}${_GREEN}>${_RESET}${_BOLD} Instalando pacote nº "$count" "$name" ${_RESET}"
	func_install_yay $name
done


echo ""
echo "${_BOLD}${_GREEN}====>${_RESET}${_BOLD} Habilitando SDDM ${_RESET}"

sudo systemctl enable sddm.service -f

cd ${path_download}
wget https://dl1.pling.com/api/files/download/j/eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjE1NTYxOTA4NTMiLCJ1IjpudWxsLCJsdCI6ImRvd25sb2FkIiwicyI6IjA1MGRlMDE2YWYyYmJhOTAwNGNiYTc5YmUyYmUxNzc3YjA5ODFlNWYzYTRmOWM0YjNiMDlmNGNlYjI0ZGRlMzcxNzg5NmZkZDI4ZDZiNzI2ZjBmY2ExYTMwZjRmZWQ0NGMyNTVlYTY5ZmQyYTAxNzU4NGNlOGJiY2RhZGZjZDYzIiwidCI6MTY0MTE4NjYzNywic3RmcCI6IjEwYzA4ZDM5NGI0N2Y5NmYyMmRmYTc5YjQ5ZTFlMmZmIiwic3RpcCI6IjE3Ny4xNTcuMTEwLjc5In0.Kd0m6N9naUXtmtSlc3vPi09UFF9iUMf1qS4ahfzmyCY/sddm-sober.tar.gz
sudo tar -xzvf ~/Downloads/sddm-sober.tar.gz -C /usr/share/sddm/themes

echo "--- Instalar o theme"
echo "  Configuração vim /etc/sddm.conf.d/sddm.conf"
echo "  [Theme]"
echo "  Current=sober"

echo ""
echo "${_BOLD}${_GREEN}====>${_RESET}${_BOLD} Configurando NeoVim ${_RESET}"
cd ${path_pwd}
mkdir ~/.config/nvim
cp conf/generate.vim  ~/.config/nvim/init.vim
cd ${path_download}

echo ""
echo "${_BOLD}${_GREEN}====>${_RESET}${_BOLD} Configurando ENV ${_RESET}"
cd ${path_pwd}
cp "${path_pwd}/conf/env.sh" "${path_conf}/."


echo ""
echo "${_BOLD}${_GREEN}====>${_RESET}${_BOLD} Configurando ZSH ${_RESET}"

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

#path_pwd

## dbeaver?
## + configuração

#tput setaf 7;echo "################################################################"
#echo "You now have a very minimal functional desktop"
#echo "################################################################"
#echo;tput sgr0

#tput setaf 11;
#echo "################################################################"
#echo "Reboot your system"
#echo "################################################################"
#echo;tput sgr0
