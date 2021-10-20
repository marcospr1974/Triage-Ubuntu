#!/bin/bash

#####################################################
#
# Nombre : 99-End.sh
# Version: 1.0
# Autor  : Marcos Pablo Russo
# Fecha  : 14/10/2021
#
# Descripcion: Live Response Collection
#              Este modulo realiza el tar del todo el contenido y sus
#              respectivos hash (md5, sha1)
#
#####################################################

# Inicialización de variables globales
source ./var.sh

result=${1}

ARCHIVO=`basename ${result}`

# Inicializo la obtención de información
printf "${color_azul}[*] Información del sistema operativo${sin_color}\n"
printf "${color_verde}   - Modulo: "
basename ${0}

# Archivo con permiso de setuid
printf "${color_celeste}%-64s ${sin_color}" "    - Realizando backup (tar)"
tar cfz Resultados/${ARCHIVO}.tgz Resultados/${ARCHIVO}
printf "${color_verde}%10s${sin_color}\n" "[OK]"

# Realización del hash (md5)
printf "${color_celeste}%-64s ${sin_color}" "    - Realizando hash (md5sum)"
md5sum Resultados/${ARCHIVO}.tgz >> Resultados/${ARCHIVO}_md5.txt
printf "${color_verde}%10s${sin_color}\n" "[OK]"

# Realización del hash (sha1)
printf "${color_celeste}%-64s ${sin_color}" "    - Realizando hash (sha1sum)"
sha1sum Resultados/${ARCHIVO}.tgz >> Resultados/${ARCHIVO}_sha1.txt
printf "${color_verde}%10s${sin_color}\n" "[OK]"

# Borrado del contenido de resultados
printf "${color_celeste}%-64s ${sin_color}" "    - Borrando ${ARCHIVO}"
rm -rf Resultados/${ARCHIVO}
printf "${color_verde}%10s${sin_color}\n" "[OK]"

echo "---------------------------------------------------------------------------"
