#!/usr/bin/env bash
# Ejercicio 25
# Muestra las líneas del comando last que contienen una dirección IP (IPv4)

echo "=== Últimos usuarios que iniciaron sesión con IP ==="
ipv4_regex='([0-9]{1,3}\.){3}[0-9]{1,3}'
last -i | egrep "$ipv4_regex"
