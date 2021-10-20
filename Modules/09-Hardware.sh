#!/bin/bash

#####################################################
#
# Nombre : 08-Hardware.sh
# Version: 1.0
# Autor  : Marcos Pablo Russo
# Fecha  : 14/09/2021
#
# Descripcion: Live Response Collection
#              Este modulo contiene la recoleccion de información del hardware.
#
#####################################################

# Inicialización de variables globales
source ./var.sh

result=${1}

# Creación del directorio
mkdir -p ${result}/09-Hardware

# Inicializo la obtención de información
printf "${color_azul}[*] Información del sistema operativo${sin_color}\n"
printf "${color_verde}   - Modulo: "
basename ${0}

# Modulos cargados
printf "${color_celeste}%-65s ${sin_color}" "    - Obtener información del hardware (lscpi)"
lspci >> $result/09-Hardware/Hardware.txt
printf "${color_verde}%10s${sin_color}\n" "[OK]"

# Modulos cargados
printf "${color_celeste}%-65s ${sin_color}" "    - Obtener información de los usb (lsusb)"
lsusb >> $result/09-Hardware/USB.txt
printf "${color_verde}%10s${sin_color}\n" "[OK]"

# Información de la memoria
printf "${color_celeste}%-65s ${sin_color}" "    - Obtener información de la memoria (/proc/meminfo)"
cat /proc/meminfo >> $result/09-Hardware/Meminfo.txt
printf "${color_verde}%10s${sin_color}\n" "[OK]"

# Información de la cpu
printf "${color_celeste}%-65s ${sin_color}" "    - Obtener información de la cpu (/proc/cpuinfo)"
cat /proc/cpuinfo >> $result/09-Hardware/Cpu.txt
printf "${color_verde}%10s${sin_color}\n" "[OK]"

# Verifico si hay array de discos
if [ -f /proc/mdstat ]; then
  printf "${color_celeste}%-64s ${sin_color}" "    - Estado de array de discos (/proc/mdstat)"
  cat /proc/mdstat >> $result/09-Hardware/Mdstat.txt
  printf "${color_verde}%10s${sin_color}\n" "[OK]"
fi

echo "---------------------------------------------------------------------------"
