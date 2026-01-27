# Practica 3 - Ejercicio 7
# Comprobar contraseña sin distinguir mayusculas y minusculas

$contraseñaCorrecta = "contraseña"

$contraseñaUsuario = Read-Host "Introducir la contraseña"

if ($contraseñaUsuario.ToLower -eq $contraseñaCorrecta.ToLower {
    Write-Host "Contraseña correcta"
}
else {
    Write-Host "Contraseña incorrecta"
}
