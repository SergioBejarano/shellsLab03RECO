#!/bin/sh

# Solicitar número de puerto
read -p "port number: " port

# Buscar el puerto en sockstat (IPv4 e IPv6)
result=$(sockstat -4 -6 | grep "\.${port} ")

# Verificar si hay resultado
if [ -n "$result" ]; then
    echo "Puerto $port está ABIERTO. Servicios encontrados:"
    echo "$result" | awk '{ print "Usuario: " $1 "\nProceso: " $2 "\nPID: " $3 "\nProtocolo: " $5 "\nDirección local: " $6 "\nDirección remota: " $7 "\n" }'
else
    echo "Puerto $port está CERRADO o no tiene servicios asociados."
fi
