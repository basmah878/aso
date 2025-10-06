#!/bin/bash
suma=0
while true; do
    read -p "Número (0 para salir): " 
    suma=$((suma + n))
done
echo "Suma final: $suma"
