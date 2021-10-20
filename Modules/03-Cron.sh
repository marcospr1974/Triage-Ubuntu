#!/bin/bash

#####################################################
#
# Nombre : 03-Cron.sh
# Version: 1.0
# Autor  : Marcos Pablo Russo
# Fecha  : 14/09/2021
#
# Descripcion: Live Response Collection
#              Este modulo contiene la recoleccion de crontab.
#
#####################################################

# Inicialización de variables globales
source ./var.sh

result=${1}

# Creación del directorio
mkdir -p ${result}/03-Cron

# Inicializo la obtención de información
printf "${color_azul}[*] Información de archivos ocultos${sin_color}\n"
printf "${color_verde}   - Modulo: "
basename ${0}

printf "${color_celeste}%-65s ${color_celeste}" "    - Información de Crontab (/etc/crontab)"
cp /etc/crontab ${result}/03-Cron/
printf "${color_verde}%10s${sin_color}\n" "  [OK]"

printf "${color_celeste}%-65s ${color_celeste}" "    - Información de Cron (/etc/cron*)"
cp -R /etc/cron* ${result}/03-Cron/
printf "${color_verde}%10s${sin_color}\n" "  [OK]"


printf "${color_celeste}%-64s ${color_celeste}" "    - Crontab de los usuarios"
for USUARIOS in `cat /etc/passwd | cut -d ':' -f1`; do
	crontab -u ${USUARIOS} -l 2> ${result}/03-Cron/${USUARIOS}-crontab.txt
done
printf "${color_verde}%10s${sin_color}\n" "  [OK]"

echo "---------------------------------------------------------------------------"
