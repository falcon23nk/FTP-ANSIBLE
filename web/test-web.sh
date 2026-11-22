#!/bin/bash

set -e

URL="http://www.noussayr.test/"

curl --fail --silent --show-error \
    --resolve www.noussayr.test:80:192.168.57.7 \
    "$URL" | grep -q "Servidor web"

echo "El servidor web responde correctamente."