#!/bin/bash
#
################################################################################
#TODO Non termine : Script de mise a jour de GLPI
################################################################################
#Passer l'URL de Dl de la Mise a jour en parametres

################################################################################
#Check Root
################################################################################
if [[ "${UID}" != 0 ]]
	then 
		echo "Vous essayez de lancer le script avec le compte: ${USER}" >2 >> ${STD_ERR}
		echo "Vous devez le lancer avec des droits root: 'sudo ${0}'" >2 >> ${STD_ERR}
		exit 1
fi
################################################################################
#Check du passage d'un parametre
################################################################################
if [[ ${#} = 0 ]]
	then
		
		echo "Vous essayez de lancer le script sans fournir de parametre" >2 >> ${STD_ERR}
		echo "Vous devez le lancer avec l'url de la mise a jour en parametre: 'sudo ${0} https://github.com/glpi-project/glpi/releases/download/9.4.4/glpi-9.4.4.tgz' " >2 >> ${STD_ERR}
		echo "Recuperer le lien de la derniere version sur : https://glpi-project.org/fr/telechargements/" >2 >>${STD_ERR}
		exit 1
fi
################################################################################
#Variables
################################################################################
PATH=/srv/

UPDATE_LINK=${1}

#TODO Recuperer la version actuelle de glpi
GLPI_CURRENT=

#Script Log
LOG_STDOUT=/var/log/glpi/update/update.out
LOG_STDERR=/var/log/glpi/update/update.err

################################################################################
#Dump de la db
################################################################################
#Copie de l'ancien dossier
cp -r ${PATH}glpi/ glpi_old_${GLPI_CURRENT}/


#date du jour
DATE=`date +%y_%m_%d`
 
#liste des dossier
LISTEBDD=$( echo 'show databases' | mysql -u root -p 2zQwxaQZvdYo27phQs16 )
 
#on boucle sur chaque dossier (for découpe automatiquement par l'espace)
for SQL in $LISTEBDD
 
	do
 
		if [ $SQL != "information_schema" ] && [ $SQL != "mysql" ] && [ $SQL != "Database" ]; then
 
			#echo $SQL
			mysqldump -u root -p 2zQwxaQZvdYo27phQs16 $SQL | gzip > ${PATH}glpi/glpi_old_${GLPI_CURRENT}/DATABASES/$SQL"_mysql_"$DATE.sql.gz
	
			if [[ ${0} != 0 ]] 
				then
		 
					echo "Echec de la Sauvegarde de la db: ${SQL}" >2 >> ${LOG_STDERR} 
				else 
					echo "Sauvegarde Réussie de la db: ${SQL} " &> ${LOG_STDOUT} 
			fi
			
		fi

	done

#Téléchargement de la nouvelle version

wget ${UPDATE_LINK} ${PATH} &> /dev/null
#check de la reussite
if [[ "${?}" != 0 ]]
	then
		echo "Echec de la recuperation de la nouvelle version" >2 >> ${LOG_STDERR} 
		exit 1
fi

# Extraction de l'archive
#Recuperation du nom de l'archive
TAR_NAME=echo "${UPDATE_LINK##*/}"

tar zxvf ${TAR_NAME} &>/dev/null
#Check de l'extraction

if [[ "${?}" != 0 ]]
	then
		echo "Echec de l'extraction de l'archive" >2 >> ${LOG_STDERR} 
		exit 1
fi
# Modification des droits

chmod -R 755 ${PATH}/glpi &> /dev/null
chown -R wwwdata:wwwdata ${PATH}/glpi &> /dev/null


# Update de la base de donnée => Se déplacer dans le dossier contenant le scripconsole

# Exécution du script de misea jour de la BDD

${PATH}glpi/bin/console db:update


# Suppression du fichier /install/install.php
 rm -f ${PATH}/glpi/install/install.php &> /dev/null

#Verifier la suppression
if [[ "${?}" != 0 ]]
	then
		echo "Echec de la suppression du fichier 'glpi/install/install.php', veuillez le supprimer manuellement" >2 >> $LOG_STDERR
fi

exit 0
