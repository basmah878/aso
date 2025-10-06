#!/bin/bash
archivo="lista.txt"

while ; do
    echo "1) Añadir  2) Buscar  3) Listar  4) Borrar  5) Salir"
    read -p "Opción: "
     $op in
        1) read -p "Nombre, Dirección, Teléfono: " info
           echo "$info" >> $archivo ;;
        2) read -p "Buscar: "
        3) cat $archivo ;;
        4) > $archivo ;;
        
    
done
