#!/bin/bash

read -p "port number: " port

outp=$(netstat -tulnp 2>/dev/null | grep ":$port ")

if [[ -n "$outp" ]]; then
    echo "$port is open"
    echo "$outp" | awk '{print "Protocolo: " $1 "\nDireccion local: " $4 "\nPID/Programa: " $7}'
else
    echo "$port is closed"
fi
