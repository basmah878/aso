#!/bin/bash
read -p "Introduce el primer número: " num1
read -p "Introduce el segundo número: " num2
media=$(( (num1 + num2) / 2 ))
echo "La media aritmética es: $media"
