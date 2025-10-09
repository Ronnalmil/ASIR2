#https://chatgpt.com/share/68e80d56-03b4-800c-886e-e08a983f0944  mejorarlo hastable
---------------------------------------------------------------------------------------------------------------------------------------------
¡Ah, perfecto! Entonces quieres que el usuario ingrese los personajes por teclado, y luego guardarlos en el archivo usando -join y Add-Content. 
Podemos hacerlo de manera interactiva con un loop para cada juego. Te muestro cómo:
-------------------------------------------------------------------------------------------------------------------------------------------------
#ejemplo interactivo
# Hashtable para almacenar los personajes
$personajesSNES = @{}

# Lista de juegos
$juegos = @("Super Mario World", "The Legend of Zelda: A Link to the Past", "Donkey Kong Country")

# Archivo de salida
$log = "C:\temp\personajes_snes.txt"

# Limpiar el archivo antes de escribir
Set-Content -Path $log -Value ""

# Recorrer cada juego
foreach ($juego in $juegos) {
    Write-Host "`nIngresa los personajes de $juego. Escribe 'fin' cuando termines."
    $personajes = @()

    while ($true) {
        $input = Read-Host "Personaje"
        if ($input -eq "fin") { break }
        $personajes += $input
    }

    # Guardar en el hashtable
    $personajesSNES[$juego] = $personajes

    # Crear la línea y escribirla en el archivo
    $linea = "$juego: " + (", " -join $personajes)
    Add-Content -Path $log -Value $linea
}

Write-Host "`nArchivo generado en $log"
------------------------------------------------------------------------------------------------------------------------------------------
🔹 Cómo funciona:

Read-Host permite que el usuario ingrese un personaje.

Se usa un while loop hasta que el usuario escriba "fin".

Cada juego se guarda en el hashtable y en el archivo de texto.

-join une los personajes con comas antes de agregarlos al archivo.
---------------------------------------------------------------------------------------------------------------------------------------------

resultado por pantalla:
Super Mario World: Mario, Luigi, Yoshi
The Legend of Zelda: A Link to the Past: Link, Zelda, Ganon
Donkey Kong Country: Donkey Kong, Diddy Kong
