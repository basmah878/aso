#Practica 3 eejrcicio8

$nombre = Read-Host "Introduce tu nombre"
$sexo = Read-Host "Introduce tu sexo (M/F)"

$letra = $nombre.

if (($sexo -eq "F" -and $letra -lt "M") -or ($sexo -eq "M" -and $letra -gt "N")) {
    Write-Host " Si Perteneces al grupo A"
}
else {
    Write-Host "Si Perteneces al grupo B"
}
