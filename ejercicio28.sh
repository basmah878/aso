#!/usr/bin/env bash
# existe_y_chmod.sh
# Uso: ./existe_y_chmod.sh archivo

if [ $# -ne 1 ]; then
  echo "Uso: $0 fichero"
  exit 1
fi

FICHERO="$1"

existe() {
  local f="$1"
  if [ -e "$f" ]; then
    return 0
  else
    return 1
  fi
}

if existe "$FICHERO"; then
  # Añadimos permiso ejecutable para el propietario y quitamos ejecución para grupo/otros
  chmod u+x,go-x "$FICHERO"
  echo "El fichero existe. Permisos cambiados: propietario ejecutable; grupo/otros sin ejecutar."
  ls -l "$FICHERO"
else
  echo "El fichero NO existe: $FICHERO"
  exit 2
fi
