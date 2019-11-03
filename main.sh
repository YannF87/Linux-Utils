#!/bin/bash
################################################################################
#Conf d'une nouvelle box avec mes préférences
################################################################################

#Check de Root
if [[ "${UID}" != 0 ]]
	then
		echo "Lancer via Sudo ou avec les droit Root"
		exit 1
fi
#Création du fichier de synthèse du script
LOG_INSTALL=~/YannSetup.info
touch ${LOG_INSTALL}

################################################################################
#GITHUB
#Récupérer et synchroniser le repo Linux-Utils
################################################################################
#Installation de GIT
apt-get install -y git
#Check de l'installation de GIT
if [[ "${?}" != 0 ]]
	then
		echo "Installation de GIT KO" >> ${LOG_INSTALL}
		exit 1
	else 
		echo "Installation de GIT OK" >> ${LOG_INSTALL}
fi
#Configuration de GIT
git remote add origin git@github.com:YannF87/Linux-Utils.git
git config --global user.email "7456641+YannF87@users.noreply.github.com"
git config --global user.name "Yann"
ssh-keygen -t rsa -b 4096 -C "7456641+YannF87@users.noreply.github.com"
ssh-add ~/.ssh/id_rsa
#Ajout de la clé publique au fichier d'install
echo >>${LOG_INSTALL}
echo >>${LOG_INSTALL}
echo "GIT Public RSA KEY à Installer sur Github" >> ${LOG_INSTALL}
echo "https://github.com/settings/keys" >>${LOG_INSTALL}
echo >>${LOG_INSTALL}
echo ~/.ssh/id_rsa.pub >> ${LOG_INSTALL}
echo >>${LOG_INSTALL}
#display de la clé publique pour enregistrement immédiat
echo 
echo 
echo "GIT Public RSA KEY à Installer sur Github" 
echo "https://github.com/settings/keys"
echo 
echo ~/.ssh/id_rsa.pub 
echo 
#Laisser le temps d'installer la clé sur Github
read -p "La clé est elle installée sur Github ?(y,n): " KEY_INSTALLED
# vérifier la réponse
if [[ "${KEY_INSTALLED}" = "n" ]]
	then 
		echo "Merci d'installer la clé"
		exit 1
	else
		git clone git@github.com:YannF87/Linux-Utils.git ~/
fi

################################################################################
#Installation & configuration des logiciels
#################################################################################
#Créer une section dans le fichier de log
echo >> ${LOG_INSTALL}
echo "### Installation et configuration des Soft" >> ${LOG_INSTALL}
echo >> ${LOG_INSTALL}
#Installer Tree, vérifier et instruire le fichier de LOG
apt-get install -y tree

if [[ "${?}" != 0 ]]
	then
		echo "Installation de tree KO" >> ${LOG_INSTALL}
		echo >> ${LOG_INSTALL}
	else 
		echo "Installation de tree OK" >> ${LOG_INSTALL}
		echo >> ${LOG_INSTALL}
fi
#Installer VIM, vérifier et instruire le fichier de log
apt-get install -y vim

if [[ "${?}" != 0 ]]
	then
		echo "Installation de VIM KO" >> ${LOG_INSTALL}
		echo >> ${LOG_INSTALL}
	else 
		echo "Installation de VIM OK" >> ${LOG_INSTALL}
		echo >> ${LOG_INSTALL}
fi
#Setup de .VIMRC
cp ~/Linux-Utils/vim/.vimrc ~/
# Copier les plugins
cp ~/Linux-Utils/vim/plugins/mswin.vim ~/.vim/


#Installer Htop
apt-get install -y htop

if [[ "${?}" != 0 ]]
	then
		echo "Installation de htop KO" >> ${LOG_INSTALL}
		echo >> ${LOG_INSTALL}
	else 
		echo "Installation de htop  OK" >> ${LOG_INSTALL}
		echo >> ${LOG_INSTALL}
fi
################################################################################
#Personnalisation de Bash
#
################################################################################
# Changement du prompt
echo "PS1='\[\033[01;35m\]###\[\033[01;36m\] \t \[\033[01;31m\]| \[\033[01;34m\]\u@\h\[\033[01;35m\] ### \n\[\033[01;31m\]>>> \[\033[01;32m\]\w\[\033[01;33m\]>\$:\[\033[00m\]'" >> ~/.bashrc

# Création des Alias
echo "alias cls='clear'" >> ~/.bashrc
echo "alias la='ls -la'" >> ~/.bashrc

# Modifier les Variables d'environement
echo 'EDITOR="vim"' >> ~/.bashrc


