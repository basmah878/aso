#!/usr/bin/env bash


SEARCH_DIR="${1:-.}"
OUTPUT_FILE="${2:-archivos_peligrosos.txt}"

# Comprobación de existencia de carpeta
if [ ! -d "$SEARCH_DIR" ]; then
  echo "Directorio no encontrado: $SEARCH_DIR"
  exit 1
fi


find "$SEARCH_DIR" -type f -perm /022 -print | sed -e "s|^\./|$PWD/|" > "$OUTPUT_FILE"

echo "Listado guardado en $OUTPUT_FILE"
echo "Total archivos: $(wc -l < "$OUTPUT_FILE")"
