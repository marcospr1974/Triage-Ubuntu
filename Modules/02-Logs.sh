#!/bin/bash

#####################################################
#
# Nombre : 02-Logs.sh
# Version: 1.0
# Autor  : Marcos Pablo Russo
# Fecha  : 14/09/2021
#
# Descripcion: Live Response Collection
#              Este modulo contiene la recoleccion de archivos de logs.
#
#####################################################

# Inicialización de variables globales
source var.sh

result=${1}

# Creación del directorio
mkdir -p ${result}/02-Logs/{etc,var,cron,apt}

# Inicializo la obtención de información
printf "${color_azul}[*] Recolección de Logs${sin_color}\n"
printf "${color_verde}   - Modulo: "
basename ${0}

# Archivos de logs abiertos
printf "${color_celeste}%-65s ${sin_color}" "    - Archivos de Logs abiertos"
lsof -i /var/log/ 1>/dev/null > ${result}/02-Logs/var/logs_open.txt
printf "${color_verde}%10s${sin_color}\n" "[OK]"

# Recolección de logs
printf "${color_celeste}%-65s ${sin_color}" "    - Recolección de Logs (/var/log/)"
cp /var/log/*.log* ${result}/02-Logs/var
printf "${color_verde}%10s${sin_color}\n" "[OK]"

# Se agrega el contenido de log de paquetes (apt)
printf "${color_celeste}%-65s ${sin_color}" "    - Recolección de Logs (/var/log/apt/*)"
cp /var/log/apt/* ${result}/02-Logs/apt
printf "${color_verde}%10s${sin_color}\n" "[OK]"

# Realización de las actualizaciones de paquetes
if [ -f /var/log/unattended-upgrades ]; then
  printf "${color_celeste}%-65s ${sin_color}" "    - Recolección de Logs (/var/log/unattended-upgrades)"
  cp /var/log/unattended-upgrades ${result}/02-Logs/var
  printf "${color_verde}%10s${sin_color}\n" "[OK]"
fi

# Recolección de logs (/var/cron*)
printf "${color_celeste}%-65s ${sin_color}" "    - Recolección de Logs (/var/cron*)"
cp -r /etc/cron* ${result}/02-Logs/cron
printf "${color_verde}%10s${sin_color}\n" "[OK]"

# Realización de las actualizaciones de paquetes
if [ -f /etc/rsyslog.conf ]; then
  printf "${color_celeste}%-65s ${sin_color}" "    - Configuración de los logs (/etc/rsyslog.*)"
  cp -a /etc/rsyslog.* ${result}/02-Logs/etc
  printf "${color_verde}%10s${sin_color}\n" "[OK]"
fi

# Recolección de logs (/var/cron*)
printf "${color_celeste}%-65s ${sin_color}" "    - Recompilación de lista de boots (journalctl)"
journalctl --list-boots > ${result}/02-Logs/list-boots.txt
printf "${color_verde}%10s${sin_color}\n" "[OK]"

# Recolección de log de booteo (journalctl)
printf "${color_celeste}%-65s ${sin_color}" "    - Recompilación de logs de boot (journalctl)"
journalctl -b > ${result}/02-Logs/log-boots.txt
printf "${color_verde}%10s${sin_color}\n" "[OK]"

# Recolección de log del kernel (journalctl)
printf "${color_celeste}%-65s ${sin_color}" "    - Recompilación de logs del kernel (journalctl)"
journalctl -k > ${result}/02-Logs/log-kernel.txt
printf "${color_verde}%10s${sin_color}\n" "[OK]"


echo "---------------------------------------------------------------------------"
