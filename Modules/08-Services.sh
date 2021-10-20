#!/bin/bash

#####################################################
#
# Nombre : 08-Services.sh
# Version: 1.0
# Autor  : Marcos Pablo Russo
# Fecha  : 14/09/2021
#
# Descripcion: Live Response Collection
#              Este modulo contiene la recoleccion de los servicios.
#
#####################################################

# Inicialización de variables globales
source ./var.sh

result=${1}

# Creación del directorio
mkdir -p ${result}/08-Services/etc

# Inicializo la obtención de información
printf "${color_azul}[*] Información del sistema operativo${sin_color}\n"
printf "${color_verde}   - Modulo: "
basename ${0}

# Proceso que se ejecutan
if [ -f /bin/systemctl ]; then
  printf "${color_celeste}%-64s ${sin_color}" "    - Estado de todos los servicio (systemctl)"
  systemctl list-unit-files >> $result/08-Services/Stat_services.txt
  printf "${color_verde}%10s${sin_color}\n" "[OK]"

  # Proceso que se ejecutan
  printf "${color_celeste}%-64s ${sin_color}" "    - Servicios que se encuentran corriendo (service)"
  systemctl list-unit-files --type=service --state=enabled >> $result/08-Services/Running_services.txt
  printf "${color_verde}%10s${sin_color}\n" "[OK]"

  # Proceso que no se ejecutan
  printf "${color_celeste}%-64s ${sin_color}" "    - Servicios que no se encuentran corriendo (service)"
  systemctl list-unit-files --type=service --state=disabled >> $result/08-Services/Not_Running_services.txt
  printf "${color_verde}%10s${sin_color}\n" "[OK]"
fi

# Proceso que no se ejecutan
printf "${color_celeste}%-64s ${sin_color}" "    - Servicios que no se encuentran corriendo (service)"
ss -ltunp >> $result/08-Services/Services_port.txt
printf "${color_verde}%10s${sin_color}\n" "[OK]"

# Configuraciones generales
if [ -d /etc/default ]; then
  printf "${color_celeste}%-64s ${sin_color}" "    - Configuraciones generales por defecto (/etc/default)"
  cp -a  /etc/default $result/08-Services/etc
  printf "${color_verde}%10s${sin_color}\n" "[OK]"
fi

# Verifico si contiene el servicio de apace
for SERVICIOS in ${servicios_ubuntu}; do
   if [ -d /etc/${SERVICIOS} ]; then
     printf "${color_celeste}%-65s ${sin_color}" "    - Copiando configuración del sercivio ${SERVICIOS}"
     cp -a /etc/${SERVICIOS} $result/08-Services/etc/
     
  #   # Verificos si el archivo es xinetd
  #   if [ "${SERVICIOS}" == "xinitd" ]; then
  #   fi

     printf "${color_verde}%10s${sin_color}\n" "[OK]"
   fi
done

echo "---------------------------------------------------------------------------"
