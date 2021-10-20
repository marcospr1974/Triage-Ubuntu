
#####################################################
#
# Nombre : 05-network.sh
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
mkdir -p ${result}/05-Network/etc/network

# Inicializo la obtención de información
printf "${color_azul}[*] Información del sistema operativo${sin_color}\n"
printf "${color_verde}   - Modulo: "
basename ${0}

# Obtner los DNS
if [ -f /etc/resolv.conf ]; then
  printf "${color_celeste}%-64s ${sin_color}" "    - DNS (/etc/resolv.conf)"
  cat /etc/resolv.conf >> $result/05-Network/resolv.txt
  printf "${color_verde}%10s${sin_color}\n" "[OK]"
fi

# Conexiones currentes
if netstat -nap &> /dev/null; then
  printf "${color_celeste}%-64s ${sin_color}" "    - Obtener las conexiones y no de los programas (netstat)"
  netstat -nap >> $result/05-Network/netstat_current_connections_and_not_program.txt
  printf "${color_verde}%10s${sin_color}\n" "[OK]"
fi

# Conexiones currentes
if netstat -s &> /dev/null; then
  printf "${color_celeste}%-64s ${sin_color}" "    - Obtener las estadisticas de conexions TCP y UDP (netstat)"
  netstat -s >> $result/05-Network/netstat_statics_tcp_udp.txt
  printf "${color_verde}%10s${sin_color}\n" "[OK]"
fi

# Promisc
printf "${color_celeste}%-64s ${sin_color}" "    - Placa de red en promiscuo"
ip link | grep -i PROMISC >> $result/05-Network/PROMISC_adapter_check.txt
printf "${color_verde}%10s${sin_color}\n" "[OK]"

# Estadisticas de Conexiones
printf "${color_celeste}%-64s ${sin_color}" "    - Estadiscticas de conexiones (ss)"
ss >> $result/05-Network/socket_statics.txt
printf "${color_verde}%10s${sin_color}\n" "[OK]"

# Lista de archivos abiertos, cantidad de link
printf "${color_celeste}%-64s ${sin_color}" "    - Listado de archivos abiertos (lsof +L)"
lsof +L 2>/dev/null >> $result/05-Network/lsof_linkcounts.txt
printf "${color_verde}%10s${sin_color}\n" "[OK]"

# Archivos de conexiones de la red
printf "${color_celeste}%-64s ${sin_color}" "    - Archivos de conexiones de la red (lsof)"
lsof -i -n -P >> $result/05-Network/lsof_network_connections.txt
printf "${color_verde}%10s${sin_color}\n" "[OK]"

# Obtener la tabla de rutas
if netstat -rn &> /dev/null; then
  printf "${color_celeste}%-64s ${sin_color}" "    - Tabla de rutas (netstat)"
  netstat -rn >> $result/05-Network/Routing_table.txt
  printf "${color_verde}%10s${sin_color}\n" "[OK]"
fi

# Obtener la tabla de arp
if arp -an &> /dev/null; then
  printf "${color_celeste}%-64s ${sin_color}" "    - Tabla de arp (arp)"
  arp -an >> $result/05-Network/ARP_table.txt
  printf "${color_verde}%10s${sin_color}\n" "[OK]"
fi

# Muestra información de las placas de red
printf "${color_celeste}%-65s ${sin_color}" "    - Información de las placas de red (ip)"
ip addr >> $result/05-Network/Network_interface.txt
printf "${color_verde}%10s${sin_color}\n" "[OK]"

# Muestra información de las placas de red
printf "${color_celeste}%-65s ${sin_color}" "    - Información de las conexiones de red (ip)"
ip neigh >> $result/05-Network/conexiones-ip.txt
printf "${color_verde}%10s${sin_color}\n" "[OK]"

# Host permitidos
if [ -f /etc/hosts ]; then
  printf "${color_celeste}%-65s ${sin_color}" "    - Información de los hosts (/etc/hosts)"
  cat /etc/hosts >> $result/05-Network/Hosts.txt
  printf "${color_verde}%10s${sin_color}\n" "[OK]"
fi

# Host permitidos
if [ -f /etc/hosts.allow ]; then
  printf "${color_celeste}%-65s ${sin_color}" "    - Información de los hosts permitidos (/etc/hosts.allow)"
  cat /etc/hosts.allow >> $result/05-Network/Hosts_allow.txt
  printf "${color_verde}%10s${sin_color}\n" "[OK]"
fi

# Host denegados
if [ -f /etc/hosts.deny ]; then
  printf "${color_celeste}%-65s ${sin_color}" "    - Información de los hosts denegados (/etc/hosts.deny)"
  cat /etc/hosts.deny >> $result/05-Network/Hosts_deny.txt
  printf "${color_verde}%10s${sin_color}\n" "[OK]"
fi

# Services
if [ -f /etc/services ]; then
  printf "${color_celeste}%-65s ${sin_color}" "    - Información de los servicios, puertos (/etc/services)"
  cp -a /etc/services $result/05-Network/etc/
  printf "${color_verde}%10s${sin_color}\n" "[OK]"
fi

# Configuración de la red
if [ -d /etc/network ]; then
  printf "${color_celeste}%-65s ${sin_color}" "    - Configuración de la red (/etc/network)"
  cp -a /etc/network $result/05-Network/etc/
  printf "${color_verde}%10s${sin_color}\n" "[OK]"
fi

# Obtención del nombre del host
if [ -f /etc/hostname ]; then
  printf "${color_celeste}%-65s ${sin_color}" "    - Obtención del nombre del host (/etc/hostname)"
  cp -a /etc/hostname $result/05-Network/etc/
  printf "${color_verde}%10s${sin_color}\n" "[OK]"
fi


# Obtención del nombre del host
if [ -f /etc/network/interfaces ]; then
  printf "${color_celeste}%-65s ${sin_color}" "    - Configuración de la red (/etc/network/interfaces)"
  cp -a /etc/network/interfaces $result/05-Network/etc/network/
  printf "${color_verde}%10s${sin_color}\n" "[OK]"
fi

echo "---------------------------------------------------------------------------"
