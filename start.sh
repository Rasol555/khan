#!/bin/sh
set -e

: "${PORT:=8080}"
: "${PANEL_PATH:=panel}"
: "${WS_PATH:=ws}"
: "${XUI_USER:=admin}"
: "${XUI_PASS:?XUI_PASS is required}"
export PORT PANEL_PATH WS_PATH

mkdir -p /etc/x-ui /run/nginx
cd /app

./x-ui setting -port 2053 -webBasePath "/${PANEL_PATH}/"

if [ ! -f /etc/x-ui/.initialized ]; then
    ./x-ui setting -username "$XUI_USER" -password "$XUI_PASS"
    touch /etc/x-ui/.initialized
fi

envsubst '${PORT} ${PANEL_PATH} ${WS_PATH}' \
    < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf

./x-ui &
sleep 3

exec nginx -g 'daemon off;'
