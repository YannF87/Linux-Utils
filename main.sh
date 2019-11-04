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
#Réinitialisation du fichier de log
echo "Début de l'installation" > ${LOG_INSTALL}

################################################################################
#MAJ de la liste des paquets
################################################################################
apt-get update

################################################################################
#GITHUB
#Récupérer et synchroniser le repo Linux-Utils
################################################################################
#Formatage du fichier de Log
echo "#### Début de L'installation et la configuration de GIT" >> ${LOG_INSTALL} 
echo >> ${LOG_INSTALL}
#Installation de GIT
apt-get install -y git
#Check de l'installation de GIT
if [[ "${?}" != 0 ]]
	then
		echo "Installation de GIT KO"
		echo "Installation de GIT KO" >> ${LOG_INSTALL}
		exit 1
	else 
		echo "Installation de GIT OK" >> ${LOG_INSTALL}
fi
#Configuration de GIT
git remote add origin git@github.com:YannF87/Linux-Utils.git
git config --global user.email "7456641+YannF87@users.noreply.github.com"
git config --global user.name "Yann"
#Clonage du repo
git clone https://github.com/YannF87/Linux-Utils.git ~/Linux-Utils 
#check du clonage

if [[ "${?}" != 0 ]]
	then
		echo "Le repo n'a pas pu être cloné"
		exit 1
	else 
		echo
		echo "Le repo Linux-Utils a été correctement cloné" >> ${LOG_INSTALL}
		echo "Le repo Linux-Utils a été correctement cloné" 
		echo
fi

#Clôture de la section GIT dans le fichier de LOG
echo >> ${LOG_INSTALL}  
echo "#### Fin  de L'installation et la configuration de GIT" >> ${LOG_INSTALL} 
echo >> ${LOG_INSTALL}


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
mkdir ~/.vim
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
#Créer une section dans le fichier de log
echo >> ${LOG_INSTALL}
echo "### Personnalisation de Bash" >> ${LOG_INSTALL}
echo >> ${LOG_INSTALL}
# Changement du prompt
echo "PS1='\[\033[01;35m\]###\[\033[01;36m\] \t \[\033[01;31m\]| \[\033[01;34m\]\u@\h\[\033[01;35m\] ### \n\[\033[01;31m\]>>> \[\033[01;32m\]\w\[\033[01;33m\]>\$:\[\033[00m\]'" >> ~/.bashrc

# Création des Alias
echo "alias cls='clear'" >> ~/.bashrc
echo "alias la='ls -la'" >> ~/.bashrc
#Instruction du fichier de log 
echo "### Alias Créés:" >> ${LOG_INSTALL}
echo "cls='clear'" >> ${LOG_INSTALL}
echo "la='ls -la'" >> ${LOG_INSTALL}
echo >> ${LOG_INSTALL}

# Modifier les Variables d'environement
echo "### Variables d'environement modifiées:" >> ${LOG_INSTALL}
echo 'EDITOR="vim"' >> ~/.bashrc
echo 'EDITOR="vim"' >> ${LOG_INSTALL}

exit 0
