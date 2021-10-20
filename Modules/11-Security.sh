#!/bin/bash

#####################################################
#
# Nombre : 11-Security.sh
# Version: 1.0
# Autor  : Marcos Pablo Russo
# Fecha  : 14/09/2021
#
# Descripcion: Live Response Collection
#              Este modulo contiene la recoleccion de seguridad.
#
#####################################################

# Inicialización de variables globales
source ./var.sh

result=${1}

# Creación del directorio
mkdir -p ${result}/11-Security/{etc,home}

# Inicializo la obtención de información
printf "${color_azul}[*] Información del sistema operativo${sin_color}\n"
printf "${color_verde}   - Modulo: "
basename ${0}

# Archivo con permiso de setuid
printf "${color_celeste}%-64s ${sin_color}" "    - Archivos con permisos 4000 y 2000"
find / -user root \( -perm -4000 -o -perm -2000 \) -type f -exec ls -ladb {} \; 2>/dev/null >> $result/11-Security/File_setuid.txt
printf "${color_verde}%10s${sin_color}\n" "[OK]"

# Información de sudoers
if [ -f /etc/sudoers ]; then
  printf "${color_celeste}%-65s ${sin_color}" "    - Archivo de configuración sudoers (/etc/sudoers)"
  cat /etc/sudoers >> $result/11-Security/File_sudoers.txt
  printf "${color_verde}%10s${sin_color}\n" "[OK]"
fi

# Archivo con permiso de setuid
printf "${color_celeste}%-65s ${sin_color}" "    - Configuración del firewall (iptables)"
iptables -L -n --line-numbers >> $result/11-Security/Firewall-iptables.txt
printf "${color_verde}%10s${sin_color}\n" "[OK]"


# Configuración de fail2ban
if [ -d /etc/fail2ban ]; then
  printf "${color_celeste}%-66s ${sin_color}" "    - Configuración para la prevención de intrusos (fail2ban)"
  cp -a /etc/fail2ban  $result/11-Security/etc
  printf "${color_verde}%10s${sin_color}\n" "[OK]"
fi


# Copio los archivos known_hosts de cada usuario
printf "${color_celeste}%-64s ${color_celeste}" "    - Copiando los archivos known_hosts de los usuarios"
while read USUARIOS; do
        USU=`echo ${USUARIOS} | cut -d ':' -f1`
        HOM=`echo ${USUARIOS} | cut -d ':' -f6`

	# Copio las conexiones
	if [ -f ${HOM}/.ssh/known_hosts ]; then
          mkdir -p ${result}/11-Security/${HOM}/.ssh
          cp -a ${HOM}/.ssh/known_hosts ${result}/11-Security/${HOM}/.ssh/
	fi
done < /etc/passwd
printf "${color_verde}%10s${sin_color}\n" "  [OK]"


# Copio los archivos config de cada usuario
printf "${color_celeste}%-64s ${color_celeste}" "    - Copiando los archivos config de los usuarios"
while read USUARIOS; do
        USU=`echo ${USUARIOS} | cut -d ':' -f1`
        HOM=`echo ${USUARIOS} | cut -d ':' -f6`

	# Copio las configuraciones de las conexiones
	if [ -f ${HOM}/.ssh/config ]; then
          mkdir -p ${result}/11-Security/${HOM}/.ssh
          cp -a ${HOM}/.ssh/config ${result}/11-Security/${HOM}/.ssh/
	fi
done < /etc/passwd
printf "${color_verde}%10s${sin_color}\n" "  [OK]"

# Copio el archivo .bashrc
printf "${color_celeste}%-64s ${color_celeste}" "    - Copiando los archivos .bashrc de los usuarios"
while read USUARIOS; do
        USU=`echo ${USUARIOS} | cut -d ':' -f1`
        HOM=`echo ${USUARIOS} | cut -d ':' -f6`

	# Copio las configuraciones de las conexiones
	if [ -f ${HOM}/.bashrc ]; then
          mkdir -p ${result}/11-Security/${HOM}/
          cp -a ${HOM}/.bashrc ${result}/11-Security/${HOM}/
	fi
done < /etc/passwd
printf "${color_verde}%10s${sin_color}\n" "  [OK]"

# Información de password de los usuarios
printf "${color_celeste}%-64s ${color_celeste}" "    - Cuando realizo el cambio de password los usuarios"
while read USUARIOS; do
        USU=`echo ${USUARIOS} | cut -d ':' -f1`

	# Copio las configuraciones de las conexiones
	passwd -S ${USU} >> ${result}/11-Security/change-password-user.txt
done < /etc/passwd
printf "${color_verde}%10s${sin_color}\n" "  [OK]"

# Usuarios pasandose por el administrador (root)
printf "${color_celeste}%-64s ${color_celeste}" "    - Usuarios pasandose por el administrador (root)"
grep ':0:' /etc/passwd > ${result}/11-Security/user-root.txt
printf "${color_verde}%10s${sin_color}\n" "  [OK]"

# Listado de creación de usuarios temporales
printf "${color_celeste}%-65s ${color_celeste}" "    - Listado de creación de usuarios temporales"
find / -nouser -print -exec ls -l {} \; 2>/dev/null > ${result}/11-Security/user-temporal.txt
printf "${color_verde}%10s${sin_color}\n" "  [OK]"

# Copio el contenido de sudo
printf "${color_celeste}%-64s ${color_celeste}" "    - Copio el contenido de sudo (/etc/sudo*)"
cp -a /etc/sudo* ${result}/11-Security/etc/
printf "${color_verde}%10s${sin_color}\n" "  [OK]"

# Buscar XX cantidad de dias de archivos modificados
printf "${color_celeste}%-64s ${color_celeste}" "    - Buscar archivos modificados de hace ${dias} dias"
find / -not \( -path /proc -prune -o -path /run -prune \) -mtime -${dias} -ls > ${result}/11-Security/file-modify.txt
printf "${color_verde}%10s${sin_color}\n" "  [OK]"

# Archivos abiertos por el administrador (root)
printf "${color_celeste}%-64s ${color_celeste}" "    - Obtener los archivos abiertos por el admin"
lsof -u root 1>/dev/null 2> ${result}/11-Security/archive_open_root.txt
printf "${color_verde}%10s${sin_color}\n" "  [OK]"

echo "---------------------------------------------------------------------------"
