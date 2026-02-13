FROM docker.n8n.io/n8nio/n8n:latest

# Базовые настройки окружения. Значения можно переопределить через Railway UI.
ENV GENERIC_TIMEZONE=Europe/Moscow \
    TZ=Europe/Moscow \
    N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=true

# Официальный образ уже слушает на 5678 и EXPOSE 5678.
# Railway сам определит порт из Dockerfile/образа и повесит HTTP-домен.

