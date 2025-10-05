#!/bin/bash
read -p "Introduce el primer número: " num1
read -p "Introduce el segundo número: " num2
if [ $num1 -gt $num2 ]; then
    echo "$num1 es mayor"
else
    echo "Los números son iguales"
fi
