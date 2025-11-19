#!/bin/bash
echo "diga cuantos usuarios quiere crear" cuantos_usuarios
usermod $cuantos_usuarios
if ( not $cuantos_usuarios) {
    echo "diga el nombre del nuevo usuario a crear" nombre_usu
    useradd $nombre_usu
    echo "diga la shell a introducir, para este usuario"
    usermod -s $nombre_usu
    echo "diga el grupo principal al que desea añadir a este usuario"
    usermod -aG sudo $nombre_usu
    echo "diga a que grupo secundario al que desea pertenecer"
    usermod -G $gruposecundario $nombre_usu
    echo "diga el directorio home "
    echo

#elif    

} 
#posiblemente tenga que usar sudo 
