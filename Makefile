.PHONY: help setup start stop restart logs clean status pull update backup

# Default profile
PROFILE ?= cpu

help: ## Show this help message
	@echo 'Usage: make [target] [PROFILE=cpu|gpu-nvidia|gpu-amd]'
	@echo ''
	@echo 'Available targets:'
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-15s %s\n", $$1, $$2}'

setup: ## Initial setup - copy .env.example to .env
	@if [ ! -f .env ]; then \
		cp .env.example .env; \
		echo "✓ Created .env file from .env.example"; \
		echo "⚠ Please edit .env and update the secrets!"; \
	else \
		echo "✓ .env file already exists"; \
	fi
	@mkdir -p shared
	@echo "✓ Created shared directory"

start: setup ## Start all services (use PROFILE=gpu-nvidia or PROFILE=gpu-amd for GPU)
	@echo "Starting services with profile: $(PROFILE)"
	@if [ "$(PROFILE)" = "cpu" ]; then \
		docker compose --profile cpu up -d; \
	else \
		docker compose --profile $(PROFILE) up -d; \
	fi
	@echo "✓ Services started. n8n is available at http://localhost:5678"

stop: ## Stop all services
	docker compose down

restart: stop start ## Restart all services

logs: ## Show logs from all services
	docker compose logs -f

logs-n8n: ## Show n8n logs only
	docker compose logs -f n8n

logs-ollama: ## Show Ollama logs only
	docker compose logs -f ollama-$(PROFILE)

status: ## Show status of all services
	docker compose ps

clean: ## Remove all volumes and data (WARNING: destructive!)
	@echo "⚠️  WARNING: This will remove all volumes and data!"
	@echo "Press Ctrl+C to cancel, or wait 5 seconds to continue..."
	@sleep 5
	docker compose down -v
	@echo "✓ All volumes removed"

pull: ## Pull latest Docker images
	docker compose pull

update: pull ## Update and restart services
	docker compose down
	docker compose up -d --force-recreate
	@echo "✓ Services updated and restarted"

backup: ## Create backup of PostgreSQL database
	@mkdir -p backups
	@TIMESTAMP=$$(date +%Y%m%d_%H%M%S); \
	docker compose exec -T postgres pg_dump -U $${POSTGRES_USER:-root} $${POSTGRES_DB:-n8n} > backups/n8n_backup_$$TIMESTAMP.sql
	@echo "✓ Backup created in backups/"

restore: ## Restore PostgreSQL database from latest backup
	@LATEST_BACKUP=$$(ls -t backups/*.sql 2>/dev/null | head -1); \
	if [ -z "$$LATEST_BACKUP" ]; then \
		echo "✗ No backup found in backups/"; \
		exit 1; \
	fi; \
	echo "Restoring from: $$LATEST_BACKUP"; \
	docker compose exec -T postgres psql -U $${POSTGRES_USER:-root} $${POSTGRES_DB:-n8n} < $$LATEST_BACKUP
	@echo "✓ Database restored"

check-env: ## Validate environment variables
	@if [ ! -f .env ]; then \
		echo "✗ .env file not found. Run 'make setup' first."; \
		exit 1; \
	fi
	@echo "Checking environment variables..."
	@grep -q "^N8N_ENCRYPTION_KEY=super-secret-key" .env && echo "⚠ WARNING: Using default N8N_ENCRYPTION_KEY" || echo "✓ N8N_ENCRYPTION_KEY is customized"
	@grep -q "^N8N_USER_MANAGEMENT_JWT_SECRET=even-more-secret" .env && echo "⚠ WARNING: Using default N8N_USER_MANAGEMENT_JWT_SECRET" || echo "✓ N8N_USER_MANAGEMENT_JWT_SECRET is customized"
	@grep -q "^POSTGRES_PASSWORD=password" .env && echo "⚠ WARNING: Using default POSTGRES_PASSWORD" || echo "✓ POSTGRES_PASSWORD is customized"

shell-n8n: ## Open a shell in the n8n container
	docker compose exec n8n /bin/sh

shell-postgres: ## Open a PostgreSQL shell
	docker compose exec postgres psql -U $${POSTGRES_USER:-root} $${POSTGRES_DB:-n8n}

generate-keys: ## Generate secure encryption keys
	@echo "N8N_ENCRYPTION_KEY=$$(openssl rand -hex 32)"
	@echo "N8N_USER_MANAGEMENT_JWT_SECRET=$$(openssl rand -hex 32)"
