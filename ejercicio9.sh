#!/bin/bash
echo "1) Sumar"
echo "2) Restar"
echo "3) Multiplicar"
echo "4) Dividir"
read -p "Elige una opción: " opcion
read -p "Introduce el primer número: " num1
read -p "Introduce el segundo número: " num2

case $opcion in
  1) echo "Resultado: $((num1 + num2))" ;;
  2) echo "Resultado: $((num1 - num2))" ;;
  3) echo "Resultado: $((num1 * num2))" ;;
  4) echo "Resultado: $((num1 / num2))" ;;
  *) echo "Opción no válida" ;;
esac
