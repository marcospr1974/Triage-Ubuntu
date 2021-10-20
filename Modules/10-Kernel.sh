#!/bin/bash

#####################################################
#
# Nombre : 09-Kernel.sh
# Version: 1.0
# Autor  : Marcos Pablo Russo
# Fecha  : 14/09/2021
#
# Descripcion: Live Response Collection
#              Este modulo contiene la recoleccion de información del kernel.
#
#####################################################

# Inicialización de variables globales
source ./var.sh

result=${1}

# Creación del directorio
mkdir -p ${result}/10-Kernel

# Inicializo la obtención de información
printf "${color_azul}[*] Información del sistema operativo${sin_color}\n"
printf "${color_verde}   - Modulo: "
basename ${0}

# Modulos cargados
printf "${color_celeste}%-65s ${sin_color}" "    - Módulos del kernel cargados (lsmod)"
lsmod | sed 1d > /tmp/modules.txt
while read module size usedby
do
  {
      echo -e $module'\t'$size'\t'$usedby;
      modprobe --show-depends $module;
      modinfo $module;
      echo "";
  } >> $result/10-Kernel/Loaded_modules.txt
done < /tmp/modules.txt
printf "${color_verde}%10s${sin_color}\n" "[OK]"


# Modulos cargados para el hardware
printf "${color_celeste}%-65s ${sin_color}" "    - Módulos del kernel cargados para el hardware (lspci)"
lspci -k >> $result/10-Kernel/Loaded_module_hardware.txt
printf "${color_verde}%10s${sin_color}\n" "[OK]"


# Obtener información de mensjae del kernel
printf "${color_celeste}%-65s ${sin_color}" "    - Obtener el mensaje del búfer del kernel (dmesg)"
{
        if dmesg -T &> /dev/null
        then
            dmesg -T
        else
            dmesg
        fi
} > $result/10-Kernel/dmesg.txt
printf "${color_verde}%10s${sin_color}\n" "[OK]"


echo "---------------------------------------------------------------------------"
