#!/bin/sh
# Fix volume permissions when mount is root-owned (e.g. Railway persistent volume).
# Контейнер стартует от root, чиним права и затем запускаем стандартный entrypoint.

chown -R node:node /home/node/.n8n 2>/dev/null || true
exec tini -- /docker-entrypoint.sh "$@"