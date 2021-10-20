#!/bin/bash

#####################################################
#
# Nombre : triage.sh
# Version: 1.0
# Autor  : Marcos Pablo Russo
# Fecha  : 13/09/2021
#
# Descripcion: Live Response Collection
#              Este software es completamente Libre, bajo la licencia GPL.
#              Mediante este software vamos a poder recolectar distinta información
#              del sistema operativo.
#
#####################################################

# Inicialización de variables globales
ScriptStart=$(date +%s)

# Versio de la aplicacion
version="GNU/Linux Live Response Collection Kit v1.0"

scriptname=`basename "$0"`
base_script=$(pwd)

# Donde se encentra los modulos
modulepath="$base_script/Modules/*.sh"

cname=$(hostname -s)
ts=$(date +%Y%m%d_%H%M)

# Hostname
hostname=$cname\_$ts

result="$base_script/Resultados/$hostname"

# Servicios
servicios_ubuntu="apache2 samba ssh"
servicios_redhat="httpd httpd2 httpd24"

# Dias de busqueda de archivos
dias=2

# Colores
color_azul="\033[1;34m"
color_celeste="\033[1;96m"
color_amarillo="\033[1;93m"
color_rojo="\033[0;31m"
color_verde="\033[0;32m"
sin_color="\033[0m"
