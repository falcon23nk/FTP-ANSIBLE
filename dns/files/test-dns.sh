#!/bin/bash

set -e

DNS="192.168.57.5"
DOMAIN="noussayr.test"

check_record() {
    NAME="$1"
    TYPE="$2"
    EXPECTED="$3"

    RESULT=$(dig +short @"$DNS" "$NAME" "$TYPE")

    if [ "$RESULT" = "$EXPECTED" ]; then
        echo "OK: $NAME -> $RESULT"
    else
        echo "ERROR: $NAME"
        echo "Esperado: $EXPECTED"
        echo "Obtenido: $RESULT"
        exit 1
    fi
}

check_record "dns.$DOMAIN" A "192.168.57.5"
check_record "ansible.$DOMAIN" A "192.168.57.6"
check_record "negocio.$DOMAIN" A "192.168.57.7"

check_record "www.$DOMAIN" CNAME "negocio.$DOMAIN."
check_record "ftp.$DOMAIN" CNAME "negocio.$DOMAIN."

check_record "5.57.168.192.in-addr.arpa" PTR "dns.$DOMAIN."
check_record "6.57.168.192.in-addr.arpa" PTR "ansible.$DOMAIN."
check_record "7.57.168.192.in-addr.arpa" PTR "negocio.$DOMAIN."

echo "Todas las pruebas DNS han finalizado correctamente."