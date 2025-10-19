#!/usr/bin/env bash


# Archivo de salida
OUTFILE="${1:-informe_ips.txt}"


get_iface_and_cidr() {
  # Usa ip -o para una línea por dirección; tomamos la primera global (scope global)
  ip -o -4 addr show scope global | awk '{print $2" "$4}' | head -n1
}

# Usa python para calcular red, broadcast, netmask y lista de IPs (excluye network y broadcast)
generate_ip_list() {
  local cidr="$1"
  python3 - <<PY
import ipaddress,sys
cidr = "$cidr"
net = ipaddress.IPv4Network(cidr, strict=False)
print(net.network_address)    # network
print(net.broadcast_address)  # broadcast
print(net.with_netmask.split('/')[1] if False else str(net.netmask))  # netmask (we'll compute)
# Print mask in dotted format
print(str(net.netmask))
# Print all usable hosts (exclude network and broadcast)
for ip in net.hosts():
    print(ip)
PY
}

# Ping una IP (devuelve 0 si responde)
ping_ip() {
  local ip="$1"
  # ping 1 paquete, timeout 1 segundo
  ping -c 1 -W 1 "$ip" >/dev/null 2>&1
  return $?
}

main() {
  local info
  info=$(get_iface_and_cidr) || { echo "No se encontró dirección IPv4 global."; exit 1; }
  IFACE=$(echo "$info" | awk '{print $1}')
  CIDR=$(echo "$info" | awk '{print $2}')
  echo "Interfaz: $IFACE"
  echo "Dirección/CIDR: $CIDR"
  echo ""

  # Generamos datos con python y los capturamos
  mapfile -t datos < <( generate_ip_list "$CIDR" )
  NETWORK="${datos[0]}"
  BROADCAST="${datos[1]}"
  NETMASK="${datos[2]}"
  # Resto de líneas son hosts
  hosts=( "${datos[@]:3}" )

  {
    echo "Informe de red generado: $(date)"
    echo "Interfaz: $IFACE"
    echo "CIDR: $CIDR"
    echo "Red (network): $NETWORK"
    echo "Broadcast: $BROADCAST"
    echo "Máscara: $NETMASK"
    echo ""
    echo "Listado de IPs (status):"
    echo "IP;STATUS"
  } > "$OUTFILE"

  # Escaneamos hosts (paralelizamos un poco con background jobs limitados)
  MAXJOBS=100   # ajusta para no saturar la red/CPU
  running=0
  tmpdir=$(mktemp -d)
  trap 'rm -rf "$tmpdir"' EXIT

  for ip in "${hosts[@]}"; do
    (
      if ping_ip "$ip"; then
        echo "$ip;ocupada" > "$tmpdir/$ip"
      else
        echo "$ip;libre" > "$tmpdir/$ip"
      fi
    ) &

    ((running++))
    if (( running >= MAXJOBS )); then
      wait -n
      ((running--))
    fi
  done

  wait

  # Ordenamos por IP y añadimos al outfile
  for f in $(ls "$tmpdir" | sort -V); do
    cat "$tmpdir/$f" >> "$OUTFILE"
  done

  echo "Informe guardado en $OUTFILE"
  echo "Red: $NETWORK/$CIDR"
  echo "Broadcast: $BROADCAST"
  echo "Mascara: $NETMASK"
  echo "Total hosts analizados: ${#hosts[@]}"
}

main "$@"
