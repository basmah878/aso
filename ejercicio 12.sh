#!/bin/bash
if [  2 ]; then
  echo "Uso: $0 origen destino"
  exit 1
fi
if [  "$1" ]; then
  echo "Error: $1 no existe."
  exit 1
fi

if [  "$2" ]; then
  echo "Error: $2 ya existe."
  exit 1
fi

cp "$1" "$2"
echo "Archivo copiado."
