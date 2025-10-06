#!/bin/bash
id="alu${ap1:0:2}${ap2:0:2}${nombre:0:1}"

if [ "$accion" == "alta" ]; then
    sudo useradd -m -g ${grupo:-$id} $id
    echo "Usuario $id creado"
elif [ "$accion" == "baja" ]; then
    sudo userdel -r $id
    echo "Usuario $id eliminado"
else
    echo "Uso: $0 alta/baja nombre apellido1 apellido2 [grupo]"
fi
