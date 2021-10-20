#!/bin/bash

#####################################################
#
# Nombre : 01-Files.sh
# Version: 1.0
# Autor  : Marcos Pablo Russo
# Fecha  : 14/09/2021
#
# Descripcion: Live Response Collection
#              Este modulo contiene la recoleccion de archivos ocultos.
#
#####################################################

# Inicialización de variables globales
source var.sh

# Creación del directorio
mkdir -p ${result}/01-Files

printf "${color_azul}[*] Información de archivos ocultos${sin_color}\n"
printf "${color_verde}   - Modulo: "
basename ${0}

printf "${color_celeste}%-65s ${sin_color}" "    - Búsqueda de archivos ocultos"
find / -name ".*" -ls 2>/dev/null >> ${result}/01-Files/HiddenFiles.txt
printf "${color_verde}%10s${sin_color}\n" "[OK]"

echo "---------------------------------------------------------------------------"
