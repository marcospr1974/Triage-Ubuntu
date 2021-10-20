#!/bin/bash

#####################################################
#
# Nombre : 07-Processes.sh
# Version: 1.0
# Autor  : Marcos Pablo Russo
# Fecha  : 14/09/2021
#
# Descripcion: Live Response Collection
#              Este modulo contiene la recoleccion de los servicios
#              y procesos.
#
#####################################################

# Inicialización de variables globales
source ./var.sh

result=${1}

# Creación del directorio
mkdir -p ${result}/07-Processes

# Inicializo la obtención de información
printf "${color_azul}[*] Información del sistema operativo${sin_color}\n"
printf "${color_verde}   - Modulo: "
basename ${0}

# Procesos que se ejecutan
printf "${color_celeste}%-65s ${sin_color}" "    - Proceso en ejecución (ps)"
ps aux --forest >> $result/07-Processes/List_of_Running_Processes.txt
printf "${color_verde}%10s${sin_color}\n" "[OK]"

# Procesos que se ejecutan en formato de arbol
printf "${color_celeste}%-66s ${sin_color}" "    - Proceso en ejecución en forma de árbol (pstree)"
pstree -ah >> $result/07-Processes/Process_tree_and_arguments.txt
printf "${color_verde}%10s${sin_color}\n" "[OK]"

# Proceso de memoria mas usada
printf "${color_celeste}%-64s ${sin_color}" "    - Proceso de memoria usada (top)"
top -n 1 -b >> $result/07-Processes/Process_memory_usage.txt
printf "${color_verde}%10s${sin_color}\n" "[OK]"


# Listar por cada proceso los archivos abiertos
printf "${color_celeste}%-64s ${sin_color}" "    - Proceso en ejecucion detallado (lsof)"
ps -eo pid,cmd | tail +2 | uniq | sed 's/^ *//' > /tmp/proc.txt
while read PROC; do
	PID=`echo ${PROC} | cut -d ' ' -f1`
	CMD=`echo ${PROC} | cut -d ' ' -f2`

	echo ${CMD} >> $result/07-Processes/Process_detail.txt
	echo "" >> $result/07-Processes/Process_detail.txt
	lsof -p ${PID} 2>/dev/null >> $result/07-Processes/Process_detail.txt
	echo "-------------------------------------------------------" >> $result/07-Processes/Process_detail.txt
done < /tmp/proc.txt
rm /tmp/proc.txt
printf "${color_verde}%10s${sin_color}\n" "[OK]"
	


echo "---------------------------------------------------------------------------"
