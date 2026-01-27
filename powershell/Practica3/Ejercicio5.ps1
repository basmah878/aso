
# Comprobar si existe un fichero o carpeta

$ruta = Read-Host "Introduce ruta del fichero o carpeta"

if (Test-Path $ruta) {
    Write-Host "El fichero o carpeta EXISTE"
}
else {
    Write-Host "El fichero o carpeta NO existe"
}
