#!/bin/sh
# Fix volume permissions when mount is root-owned (e.g. Railway persistent volume).
# Must run as root; then we drop to node and start n8n.

chown -R node:node /home/node/.n8n 2>/dev/null || true
exec gosu node tini -- /docker-entrypoint.sh "$@"