#!/bin/bash
dir=$1
if [ -d "$dir" ]; then
    fecha=$(date +%F)
    tar -czf "${fecha}_$.tar.gz" "$dir"
    echo "Archivo comprimido creado: ${fecha}_$(basename dir).tar.gz"
else
    echo "El directorio no existe"
fi
