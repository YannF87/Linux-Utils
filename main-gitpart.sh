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


exit 0
