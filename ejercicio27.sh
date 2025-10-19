#!/usr/bin/env bash
# agenda.sh
# Agenda simple con funciones: añadir, listar, buscar, borrar, editar.
# Fichero: agenda.csv (Nombre;Telefono;Email)

AGENDA_FILE="${1:-agenda.csv}"
touch "$AGENDA_FILE"

# Validaciones
validar_telefono() {
  local t="$1"
  # Acepta: números (9-15 dígitos), puede empezar con + y permitir espacios o guiones
  if [[ "$t" =~ ^\+?[0-9][0-9\ \-]{7,14}[0-9]$ ]]; then
    return 0
  else
    return 1
  fi
}

validar_email() {
  local e="$1"
  # Regex razonable para emails (no perfecta, pero robusta)
  if [[ "$e" =~ ^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$ ]]; then
    return 0
  else
    return 1
  fi
}

añadir_contacto() {
  echo "Añadir contacto:"
  read -p "Nombre: " nombre
  read -p "Teléfono: " telefono
  read -p "Email: " email

  if ! validar_telefono "$telefono"; then
    echo "Teléfono inválido. Debe tener entre 9 y 15 cifras, puede incluir +, espacios o guiones."
    return 1
  fi
  if ! validar_email "$email"; then
    echo "Email inválido."
    return 1
  fi

  echo "${nombre};${telefono};${email}" >> "$AGENDA_FILE"
  echo "Contacto añadido."
}

listar_contactos() {
  echo "LISTADO DE CONTACTOS:"
  if [ ! -s "$AGENDA_FILE" ]; then
    echo "(La agenda está vacía)"
    return 0
  fi
  nl -w3 -s". " "$AGENDA_FILE" | while IFS= read -r line; do
    # Mostrar con formato
    IFS=';' read -r n t e <<< "$(echo "$line" | sed 's/^[[:space:]]*[0-9]\+\.\s*//')"
    echo "$line" | awk -F';' '{printf "%s\n", $0}'
  done
}

buscar_contacto() {
  read -p "Buscar por nombre, teléfono o email (fragmento): " q
  grep -in -- "$q" "$AGENDA_FILE" || echo "No se encontraron coincidencias."
}

borrar_contacto() {
  read -p "Introduce el texto que identifique el contacto a borrar (nombre o email): " q
  grep -in -- "$q" "$AGENDA_FILE" || { echo "No encontrado."; return 1; }
  echo "Coincidencias:"
  grep -in -- "$q" "$AGENDA_FILE"
  read -p "¿Borrar todas las líneas que contienen '$q'? (s/n): " conf
  if [[ "$conf" =~ ^[sS]$ ]]; then
    # Guardar en temporal
    cp "$AGENDA_FILE" "${AGENDA_FILE}.bak"
    grep -vi -- "$q" "${AGENDA_FILE}.bak" > "$AGENDA_FILE"
    echo "Borrado. Backup en ${AGENDA_FILE}.bak"
  else
    echo "Operación cancelada."
  fi
}

editar_contacto() {
  read -p "Introduce el texto que identifique el contacto a editar (nombre o email): " q
  matches=$(grep -in -- "$q" "$AGENDA_FILE" || true)
  if [ -z "$matches" ]; then
    echo "No encontrado."
    return 1
  fi
  echo "Coincidencias:"
  echo "$matches"
  read -p "Introduce el número de línea a editar: " lineno
  if ! awk "NR==$lineno{print; exit}" "$AGENDA_FILE" >/dev/null 2>&1; then
    echo "Línea inválida."
    return 1
  fi
  old_line=$(sed -n "${lineno}p" "$AGENDA_FILE")
  IFS=';' read -r old_name old_tel old_email <<< "$old_line"
  echo "Valores actuales: Nombre='$old_name' Teléfono='$old_tel' Email='$old_email'"

  read -p "Nuevo Nombre (enter para dejar '$old_name'): " new_name
  read -p "Nuevo Teléfono (enter para dejar '$old_tel'): " new_tel
  read -p "Nuevo Email (enter para dejar '$old_email'): " new_email

  new_name=${new_name:-$old_name}
  new_tel=${new_tel:-$old_tel}
  new_email=${new_email:-$old_email}

  if ! validar_telefono "$new_tel"; then
    echo "Teléfono inválido. Edición cancelada."
    return 1
  fi
  if ! validar_email "$new_email"; then
    echo "Email inválido. Edición cancelada."
    return 1
  fi

  new_line="${new_name};${new_tel};${new_email}"
  # Reemplazamos la línea de forma segura
  awk -v n="$lineno" -v nl="$new_line" 'NR==n{$0=nl} {print}' "$AGENDA_FILE" > "${AGENDA_FILE}.tmp" && mv "${AGENDA_FILE}.tmp" "$AGENDA_FILE"
  echo "Contacto actualizado."
}

imprimir_menu() {
  cat <<EOF
AGENDA - Archivo: $AGENDA_FILE
1) Añadir contacto
2) Listar contactos
3) Buscar contacto
4) Borrar contacto
5) Editar contacto
6) Salir
EOF
}

# Bucle principal
while true; do
  imprimir_menu
  read -p "Elige una opción [1-6]: " opt
  case "$opt" in
    1) añadir_contacto ;;
    2) listar_contactos ;;
    3) buscar_contacto ;;
    4) borrar_contacto ;;
    5) editar_contacto ;;
    6) echo "Guardado en $AGENDA_FILE. Adiós."; exit 0 ;;
    *) echo "Opción inválida." ;;
  esac
  echo
done
