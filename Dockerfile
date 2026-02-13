FROM docker.n8n.io/n8nio/n8n:latest

# Запускаем от root только чтобы в entrypoint поправить права на volume (Railway и др.).
USER root

# База образа у Railway без apk, ставим gosu через apt
RUN apt-get update \
 && apt-get install -y --no-install-recommends gosu \
 && rm -rf /var/lib/apt/lists/*

COPY docker-entrypoint-n8n.sh /docker-entrypoint-n8n.sh
RUN chmod +x /docker-entrypoint-n8n.sh

# Базовые настройки окружения. Значения можно переопределить через Railway UI.
ENV GENERIC_TIMEZONE=Europe/Moscow \
    TZ=Europe/Moscow \
    N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=true \
    N8N_TUNNEL_ENABLED=true

# Entrypoint: chown volume для node, затем запуск n8n от пользователя node.
ENTRYPOINT ["/docker-entrypoint-n8n.sh"]

# Официальный образ уже слушает на 5678 и EXPOSE 5678.
# Railway сам определит порт из Dockerfile/образа и повесит HTTP-домен.
# WEBHOOK_URL задаётся в Railway Variables (например https://${RAILWAY_PUBLIC_DOMAIN}).