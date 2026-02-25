#!/bin/bash
# crea el crontab automático 
# Comandos a usar,
ls -la ruta,
date 

* * * * * /usr/bin/date  >  /tmp/time.txt

# Casos :  Todos los dias a las 3AM
m H d M s
* 3 * * * /usr/bin/date  > /tmp/time.txt

# Caso : Todos los 1 de cada enero y Lunes
* 3 1 1 1

# Caso:  Cada 10 minutos 
0/10 * * * * /usr/bin/date > /tmp/time.txt

# Caso:  atajos  :  @dayly  @month y así varios


