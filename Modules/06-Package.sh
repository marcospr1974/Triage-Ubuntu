
#####################################################
#
# Nombre : 06-Package.sh
# Version: 1.0
# Autor  : Marcos Pablo Russo
# Fecha  : 14/09/2021
#
# Descripcion: Live Response Collection
#              Este modulo contiene la recoleccion de información de paquetes.
#
#####################################################

# Inicialización de variables globales
source ./var.sh

result=${1}

# Creación del directorio
mkdir -p ${result}/06-Package

# Inicializo la obtención de información
printf "${color_azul}[*] Información del sistema operativo${sin_color}\n"
printf "${color_verde}   - Modulo: "
basename ${0}

# Obtener detalle de todos los paquetes
if [ -d /etc/apt ]; then
  printf "${color_celeste}%-65s ${sin_color}" "    - Configuración de repositorios (/etc/apt/)"
  cp -a /etc/apt  $result/06-Package/
  printf "${color_verde}%10s${sin_color}\n" "[OK]"
fi

# Obtener todos los paquetes
if [ -f /usr/bin/dpkg ]; then
  printf "${color_celeste}%-64s ${sin_color}" "    - Paquetes (dpkg)"
  dpkg -l >> $result/06-Package/dpkg.txt
  printf "${color_verde}%10s${sin_color}\n" "[OK]"
fi

# Obtener todos los paquetes
if [ -f /usr/bin/dpkg ]; then
  printf "${color_celeste}%-64s ${sin_color}" "    - Obtener todos los paquetes (dpkg)"
  dpkg -s >> $result/06-Package/dpkg_detail.txt
  printf "${color_verde}%10s${sin_color}\n" "[OK]"
fi

# Obtener detalle de todos los paquetes
if [ -f /usr/bin/dpkg ]; then
  printf "${color_celeste}%-64s ${sin_color}" "    - Obtener detalle de todos los paquetes (dpkg)"
  dpkg -s >> $result/06-Package/dpkg_detail.txt
  printf "${color_verde}%10s${sin_color}\n" "[OK]"
fi

# Obtener detalle de todos los paquetes y su version
if dpkg-query -W &> /dev/null; then
  printf "${color_celeste}%-64s ${sin_color}" "    - Obtener detalle de todos los paquetes (dpkg)"
  dpkg-query -W  > $result/06-Package/dpkg_version.txt
  printf "${color_verde}%10s${sin_color}\n" "[OK]"
fi

echo "---------------------------------------------------------------------------"
