
$ruta = Read-Host "Introduce la ruta"

if (Test-Path $ruta) {

    if Write-Host "Es un directorio. Contenido:"
    else {
        Write-Host "Existe, pero NO es un directorio"
    }

}
else {
    Write-Host "La ruta no existe"
}
