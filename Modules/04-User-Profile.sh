#!/bin/bash

#####################################################
#
# Nombre : 04-User-Profile.sh
# Version: 1.0
# Autor  : Marcos Pablo Russo
# Fecha  : 14/09/2021
#
# Descripcion: Live Response Collection
#              Este obtenemos información de los usuarios.
#
#####################################################

# Inicialización de variables globales
source ./var.sh

result=${1}

# Creación del directorio
mkdir -p $result/04-User-Profile/{etc,home}

# Inicializo la obtención de información
printf "${color_azul}[*] Información de archivos ocultos${sin_color}\n"
printf "${color_verde}   - Modulo: "
basename ${0}

# Mis conexiones
printf "${color_celeste}%-66s${sin_color}" "    - Información de los logueos (w)"
w >> $result/04-User-Profile/Logged_Users.txt
printf "${color_verde}%10s${sin_color}\n" "  [OK]"

# Mis conexiones
printf "${color_celeste}%-65s${sin_color}" "    - Usuario actual conexiones (who -a)"
who -a >> $result/04-User-Profile/Logged_In_Users.txt
printf "${color_verde}%10s${sin_color}\n" "  [OK]"

# Obtengo todas los login al sistema
echo "Todas las conexiones :" >> $result/04-User-Profile/Lastlog_In_Users.txt
printf "${color_celeste}%-65s${sin_color}" "    - Todas las conexiones (lastlog)"
faillog >> $result/04-User-Profile/Lastlog_In_Users.txt
printf "${color_verde}%10s${sin_color}\n" "  [OK]"

# Obtengo todas los login al sistema
echo "Todas las conexiones :" >> $result/04-User-Profile/Lastlog_In_Users.txt
printf "${color_celeste}%-65s${sin_color}" "    - Conexiones falladas (faillog)"
lastlog >> $result/04-User-Profile/Faillog_In_Users.txt
printf "${color_verde}%10s${sin_color}\n" "  [OK]"

# Obtengo el ultimpo logeo
echo "Ultimo logeo :" >> $result/04-User-Profile/Last_In_Users.txt
printf "${color_celeste}%-65s${sin_color}" "    - Ultimo logeos de los usuarios (last -Fwx)"
last -Fwx >> $result/04-User-Profile/Last_In_Users.txt
printf "${color_verde}%10s${sin_color}\n" "  [OK]"

# Obtengo la copia del profile
if [ -f /etc/profile ]; then
  printf "${color_celeste}%-65s${sin_color}" "    - Copia del profile (/etc/profile)"
  cp /etc/profile $result/04-User-Profile/etc/
  printf "${color_verde}%10s${sin_color}\n" "  [OK]"
fi

# Obtengo la copia del profile
if [ -d /etc/profile.d ]; then
  printf "${color_celeste}%-65s${sin_color}" "    - Copia del contenido de profile (/etc/profile.d/)"
  cp -R /etc/profile.d $result/04-User-Profile/etc/
  printf "${color_verde}%10s${sin_color}\n" "  [OK]"
fi

# Copiar el contenido de usuarios
printf "${color_celeste}%-65s${sin_color}" "    - Copia el contenido de usuarios (/etc/passwd*)"
cp /etc/passwd* $result/04-User-Profile/etc/
printf "${color_verde}%10s${sin_color}\n" "  [OK]"

# Copia el contenido de claves (/etc/shadow*)
printf "${color_celeste}%-65s${sin_color}" "    - Copia el contenido de claves (/etc/shadow*)"
cp /etc/shadow* $result/04-User-Profile/etc/
printf "${color_verde}%10s${sin_color}\n" "  [OK]"

# Copiar los grupos de usuarios
printf "${color_celeste}%-65s${sin_color}" "    - Copia el contenido de grupos (/etc/group*)"
cp /etc/group* $result/04-User-Profile/etc/
printf "${color_verde}%10s${sin_color}\n" "  [OK]"

# Copio el contenido de los grupos con password
printf "${color_celeste}%-58s ${color_celeste}" "    - Copio el contenido de los grupos con pass. (/etc/gshadow*)"
cp -a /etc/gshadow* ${result}/04-User-Profile/etc/
printf "${color_verde}%10s${sin_color}\n" "  [OK]"

# ID de todos los usuarios
printf "${color_celeste}%-65s${sin_color}" "    - ID de todos los usuarios (id)"
for i in `cat /etc/passwd | cut -d':' -f1`; do
   id ${i} >> $result/04-User-Profile/id-user.txt
done
printf "${color_verde}%10s${sin_color}\n" "  [OK]"

# Copiamos todo los .bash_history de todos los usuarios
printf "${color_celeste}%-65s${sin_color}" "    - Historial de bash de cada usuario (.bash_history)"
for i in `ls /home/`; do
   cat /home/${i}/.bash_history > $result/04-User-Profile/home/home-${i}-bash_history.txt
done
printf "${color_verde}%10s${sin_color}\n" "  [OK]"

# Copiamos todo los .bashrc de todos los usuarios
printf "${color_celeste}%-65s${sin_color}" "    - Copio el contenido del bashrc por cada usuario"
for i in `ls /home/`; do
   cat /home/${i}/.bashrc > $result/04-User-Profile/home/home-${i}-bashrc.txt
done
printf "${color_verde}%10s${sin_color}\n" "  [OK]"

# Copiar el contenido de /etc/skel
if [ -d /etc/skel ]; then
  printf "${color_celeste}%-65s${sin_color}" "    - Copia todo el contenido de skel(/etc/skel/)"
  cp -R /etc/skel $result/04-User-Profile/etc/
  printf "${color_verde}%10s${sin_color}\n" "  [OK]"
fi

echo "---------------------------------------------------------------------------"
