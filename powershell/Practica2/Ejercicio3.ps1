# Ejercicio 3 - Calcular salario
$horas = Read-Host "Número de horas trabajadas"
$coste = Read-Host "Coste por hora"

$horas = [double]$horas
$coste = [double]$coste

$salario = $horas * $coste
Write-Host "El salario a pagar es: $salario €"
