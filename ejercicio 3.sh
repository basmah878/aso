#!/bin/bash
ls /etc > listado.txt
cat listado.txt
echo "Número de líneas: $(wc -l < listado.txt)"
echo "Número de palabras: $(wc -w < listado.txt)"
