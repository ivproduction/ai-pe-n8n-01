# Переменные
PYTHON = python3
VENV = .venv
BIN = $(VENV)/bin

.PHONY: install run docker-clean help

help: ## Показать это меню
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

install: ## Создать venv и поставить зависимости
	$(PYTHON) -m venv $(VENV)
	$(BIN)/pip install --upgrade pip
	$(BIN)/pip install -r requirements.txt
	cp .env.example .env
	@echo "✅ Установка завершена. Настрой .env файл!"

run: ## Запустить Python бота
	$(BIN)/python src/main.py

docker-up: ## Поднять инфраструктуру (n8n, базы)
	docker-compose up -d
	@echo "🐳 Контейнеры запущены!"

docker-down: ## Остановить всё
	docker-compose down

clean: ## Удалить временные файлы и venv
	rm -rf $(VENV)
	find . -type d -name "__pycache__" -exec rm -rf {} +




