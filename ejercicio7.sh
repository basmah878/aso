#!/bin/bash

if [ -z "$1" ]; then
  echo "Uso: $0 directorio"
  exit 1
fi
tar -czf "$(date +%F)_$1.tar.gz" "$1"

echo "Archivo creado: $(date +%F)_$1.tar.gz"
