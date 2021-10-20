#!/bin/bash

#####################################################
#
# Nombre : 00-Basic-Info.sh
# Version: 1.0
# Autor  : Marcos Pablo Russo
# Fecha  : 14/09/2021
#
# Descripcion: Live Response Collection
#              Este modulo contiene la recoleccion del sistema operativo.
#
#####################################################

# Inicialización de variables globales
source ./var.sh

result=${1}

# Creación del directorio
mkdir -p ${result}/00-BasicInfo/etc

# Inicializo la obtención de información
printf "${color_azul}[*] Información del sistema operativo${sin_color}\n"
printf "${color_verde}   - Modulo: "
basename ${0}

# Obtención de la versión del kernel
printf "${color_celeste}%-64s ${sin_color}" "    - Fecha y Hora del equipo (date)"
date >> $result/00-BasicInfo/date.txt
printf "${color_verde}%10s${sin_color}\n" "[OK]"

# Obtención el nombre del host
printf "${color_celeste}%-64s ${sin_color}" "    - Obtener el nombre del host (hostname)"
hostname >> $result/00-BasicInfo/hostname.txt
printf "${color_verde}%10s${sin_color}\n" "[OK]"

# Obtención la ip del host
printf "${color_celeste}%-64s ${sin_color}" "    - Obtener la ip del host (hostname -I)"
hostname -I >> $result/00-BasicInfo/ip.txt
printf "${color_verde}%10s${sin_color}\n" "[OK]"

# Obtención del dominio
printf "${color_celeste}%-64s ${sin_color}" "    - Obtener el dominio (hostname -d)"
hostname -d >> $result/00-BasicInfo/domain.txt
printf "${color_verde}%10s${sin_color}\n" "[OK]"

# Obtener el fqdn (host + domain)
printf "${color_celeste}%-64s ${sin_color}" "    - Obtener el fqdn (hostname -f)"
hostname -f >> $result/00-BasicInfo/host_domain.txt
printf "${color_verde}%10s${sin_color}\n" "[OK]"

# Obtención de cuanto hace que esta prendido el equipo
printf "${color_celeste}%-64s ${sin_color}" "    - Tiempo de encendido del equipo (uptime)"
uptime >> $result/00-BasicInfo/uptime.txt
printf "${color_verde}%10s${sin_color}\n" "[OK]"

# Obtención de cuanto hace que esta prendido el equipo
printf "${color_celeste}%-64s ${sin_color}" "    - Variable de entorno (printenv)"
printenv >> $result/00-BasicInfo/printenv.txt
printf "${color_verde}%10s${sin_color}\n" "[OK]"

# Version del Kernel
printf "${color_celeste}%-66s ${sin_color}" "    - Información de la versión del kernel (/proc/version)"
cat /proc/version >> $result/00-BasicInfo/OS_kernel_version.txt
printf "${color_verde}%10s${sin_color}\n" "[OK]"

# Obtener información de la version de GNU/Linux
if [ -f /etc/lsb-release ]; then
  cat /etc/lsb-release >> $result/00-BasicInfo/InfOS.txt
fi

# Obtener información de la version de GNU/Linux
if [ -f /etc/os-release ]; then
  cat /etc/os-release >> $result/00-BasicInfo/InfOS.txt
fi

# Obtner los DNS
if [ -f /etc/resolv.conf ]; then
  printf "${color_celeste}%-64s ${sin_color}" "    - DNS (/etc/resolv.conf)"
  cat /etc/resolv.conf >> $result/00-BasicInfo/resolv.txt
  printf "${color_verde}%10s${sin_color}\n" "[OK]"
fi

# Puntos de montajes
printf "${color_celeste}%-64s ${sin_color}" "    - Puntos de montajes (mount)"
mount >> $result/00-BasicInfo/Mounted_items.txt
printf "${color_verde}%10s${sin_color}\n" "[OK]"

# Puntos de montajes declarados
printf "${color_celeste}%-64s ${sin_color}" "    - Puntos de montajes declarados (/etc/fstab)"
cat /etc/fstab >> $result/00-BasicInfo/Declare_Mounted_items.txt
printf "${color_verde}%10s${sin_color}\n" "[OK]"

# Información de los dispositivos de bloques
if [ -f /bin/lsblk ]; then
  printf "${color_celeste}%-64s ${sin_color}" "    - Listado de bloques de dispositivos (lsblk)"
  lsblk >> $result/00-BasicInfo/Declare_Mounted_items.txt
  printf "${color_verde}%10s${sin_color}\n" "[OK]"
fi

# Información de las particiones de los discos
printf "${color_celeste}%-64s ${sin_color}" "    - Listado de las particiones de discos (fdisk)"
fdisk -l >> $result/00-BasicInfo/Partition_disk.txt
printf "${color_verde}%10s${sin_color}\n" "[OK]"

# Configuración de la zona horaria
if [ -f /etc/timezone ]; then
  printf "${color_celeste}%-65s ${sin_color}" "    - Configuración de la zona horaria (/etc/timezone)"
  cp -a /etc/timezone $result/00-BasicInfo/etc
  printf "${color_verde}%10s${sin_color}\n" "[OK]"
fi

# Obtención de las shells instaladas
printf "${color_celeste}%-65s ${sin_color}" "    - Obtención de las shells instalada (/etc/shells)"
cp -a /etc/shells $result/00-BasicInfo/etc/
printf "${color_verde}%10s${sin_color}\n" "[OK]"

# Información de la memoria detallada
printf "${color_celeste}%-65s ${sin_color}" "    - Información de la memoria detallada (/proc/meminfo)"
cat /proc/meminfo > $result/00-BasicInfo/meminfo-detail.txt
printf "${color_verde}%10s${sin_color}\n" "[OK]"

# Información de la memoria 
printf "${color_celeste}%-65s ${sin_color}" "    - Información de la memoria (free)"
free > $result/00-BasicInfo/free-mem.txt
printf "${color_verde}%10s${sin_color}\n" "[OK]"

# Información de la cpu
printf "${color_celeste}%-65s ${sin_color}" "    - Información de la cpu (/proc/cpuinfo)"
cat /proc/cpuinfo > $result/00-BasicInfo/cpuinfo.txt
printf "${color_verde}%10s${sin_color}\n" "[OK]"

# Ïnformación de puntos de montajes
printf "${color_celeste}%-65s ${sin_color}" "    - Información de puntos de montajes (/proc/mounts)"
cat /proc/mounts > $result/00-BasicInfo/mounts.txt
printf "${color_verde}%10s${sin_color}\n" "[OK]"

echo "---------------------------------------------------------------------------"
