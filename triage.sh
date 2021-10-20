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

# Cargo las variables de entorno
source ./var.sh

# Inicializo el programa principal
function titulo() {
  clear
  cat logo.txt
  echo -e "${sin_color}"
}

# Llamo a la funcion de titulo
titulo

# Verifico si lo ejecuta el administrador (root)
[[ $UID == 0 || $EUID == 0 ]] || (
  echo "Must be root! Please execute after 'su -' OR with 'sudo' . "
  exit 1
) || exit 1

echo -e ${color_azul}"[*] Creación del directorio ${sin_color}"
echo -e ${color_verde}"   - ${result} ${sin_color}"
mkdir -p ${result}
echo "---------------------------------------------------------------------------"

directorio=${result}

# Inicializa la carga de los modulos
for modulos in `ls -1 ${modulepath}`; do
	${modulos} ${directorio}
done
