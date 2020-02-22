#!/usr/bin/env bash

DIRETORIO_DOWNLOADS="$HOME/Downloads/programas"
URL_VISUAL_STUDIO="https://go.microsoft.com/fwlink/?LinkID=760680"

PROGRAMAS_PARA_INSTALAR=(
  git
  htop
  openjdk-11-jdk
  openjdk-11-doc
  openjdk-11-source
  openjdk-11-jdk-headless
  keepassxc
  ecplise
  apt-transport-https 
  ca-certificates
  software-properties-common  
  docker*
  wine-stable*
  winehq-stable
  nodejs
  npm
  build-essential
  ffmpeg
  obs-studio
)
# ---------------------------------------------------------------------- #

# ----------------------------- REQUISITOS ----------------------------- #
## Removendo travas eventuais do apt ##
sudo rm /var/lib/dpkg/lock-frontend
sudo rm /var/cache/apt/archives/lock

sudo add-apt-repository ppa:obsproject/obs-studio

sudo apt-get update

wget -c "$URL_VISUAL_STUDIO"       -P "$DIRETORIO_DOWNLOADS"

## Adicionando/Confirmando arquitetura de 32 bits ##
sudo dpkg --add-architecture i386

## Instalando pacotes .deb baixados na sessão anterior ##
sudo dpkg -i $DIRETORIO_DOWNLOADS/*.deb

# Instalar programas no apt
for nome_do_programa in ${PROGRAMAS_PARA_INSTALAR[@]}; do
  if ! dpkg -l | grep -q $nome_do_programa; then # Só instala se já não estiver instalado
    sudo apt install "$nome_do_programa" -y
  else
    echo "[INSTALADO] - $nome_do_programa"
  fi
done

## Instalando pacotes Snap ##
sudo snap install gitkraken
snap install postman
sudo snap install slack --classic
sudo snap install skype --classic
sudo snap install spotify
sudo snap install --classic code

sudo npm install -g create-react-app
sudo npm install -g @vue/cli
sudo npm install -g @angular/cli

# ----------------------------- PÓS-INSTALAÇÃO ----------------------------- #

sudo usermod -aG docker whoami  

## Finalização, atualização e limpeza##
sudo apt update && sudo apt dist-upgrade -y
flatpak update
sudo apt autoclean
sudo apt autoremove -y
# ---------------------------------------------------------------------- #
