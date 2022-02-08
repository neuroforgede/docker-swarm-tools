#!/bin/sh

check_result () {
    ___RESULT=$?
    if [ $___RESULT -ne 0 ]; then
        echo $1
        exit 1
    fi
}

envsubst '$WORKER_CONNECTIONS, $TCP_PROXY_LISTEN_PORT, $DNS_RESOLVER, $DNS_RESOLVER_VALID, $TCP_UPSTREAM' < /etc/nginx/templates/nginx.conf > /etc/nginx/nginx.conf
check_result "failed to template /etc/nginx/nginx.conf"

if [ -z "$TCP_UPSTREAM" ]; then
    echo "env variable TCP_UPSTREAM must be set"
    exit 1
fi

exec nginx -g 'daemon off;'