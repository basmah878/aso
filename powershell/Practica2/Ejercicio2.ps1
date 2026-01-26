# Ejercicio 2 - Operaciones con dos números
$numero1 = Read-Host "Introduce el primer número"
$numero2 = Read-Host "Introduce el segundo número"

# Convertir a enteros
$numero1 = [int]$numero1
$numero2 = [int]$numero2

Write-Host "Suma: $($numero1 + $numero2)"
Write-Host "Resta: $($numero1 - $numero2)"
Write-Host "Multiplicación: $($numero1 * $numero2)"
Write-Host "División: $($numero1 / $numero2)"
Write-Host "Resto: $($numero1 % $numero2)"
