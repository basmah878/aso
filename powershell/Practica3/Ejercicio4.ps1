

Write-Host 
Write-Host "1. Sumar"
Write-Host "2. Restar"
Write-Host "3. Multiplicar"
Write-Host "4. Dividir"

$opcion = Read-Host "¿Quue quieres hacer? Elige una opción"

$num1 = Read-Host "Introduce el primer numero"
$num2 = Read-Host "Introduce el segundo numero"

$num1 = [double]$num1
$num2 = [double]$num2

switch ($opcion) {
    1 { Write-Host "Resultado: $($num1 + $num2)" }
    2 { Write-Host "Resultado: $($num1 - $num2)" }
    3 { Write-Host "Resultado: $($num1 * $num2)" }
    4 { 
     
}
