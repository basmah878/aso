$edad = Read-Host "Introduce tu edad"
$edad = [int]$edad

if ($edad  18) {
    Write-Host "Eres mayor de edad"
} else 
    Write-Host "No eres mayor de edad"
}
