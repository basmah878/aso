#PRACTICA 3 EJERCICIO 11

$edad = Read-Host "Introduce tu edad"
$edad = [int]$edad

if ($edad -lt 4) {
    Write-Host "Entrada gratis"
}
elseif ($edad -le 18) {
    Write-Host "Precio de  entrada: 5 €"
}
else {
    Write-Host "Precio de entrada: 10 €"
}
