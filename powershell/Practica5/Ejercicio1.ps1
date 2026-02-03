# Practica 5 - Ejercicio 1
# Calculadora 

function Sumar($a, $b) {
    return $a + $b
}

function Restar($a, $b) {
    return $a - $b
}

function Multiplicar($a, $b) {
    return $a * $b
}

function Dividir($a, $b) {
    if ($b -ne 0) {
        return $a / $b
    }
    else {
        return "No se puede dividir entre 0"
    }
}

Write-Host "****** CALCULADORA ******"
Write-Host "1. Sumar"
Write-Host "2. Restar"
Write-Host "3. Multiplicar"
Write-Host "4. Dividir"
Write-Host "5. Salir"

$opcion = Read-Host "¿Que quieres hacer? Elige una opción"

if ($opcion -ne 5) {

    $num1 = Read-Host "Introducir el primer número"
    $num2 = Read-Host "Introducir el segundo número"

    $num1 = [int]$num1
    $num2 = [int]$num2

    switch ($opcion) {
        1 { Write-Host "Resultado:" (Sumar $num1 $num2) }
        2 { Write-Host "Resultado:" (Restar $num1 $num2) }
        3 { Write-Host "Resultado:" (Multiplicar $num1 $num2) }
        4 { Write-Host "Resultado:" (Dividir $num1 $num2) }
        default { Write-Host "incorrecta" }
    }
}
else {
    Write-Host "SALIR"
}
