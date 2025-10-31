.PHONY: help install dev build start stop clean seed test

help: ## Show this help message
	@echo 'Usage: make [target]'
	@echo ''
	@echo 'Available targets:'
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  %-15s %s\n", $$1, $$2}' $(MAKEFILE_LIST)

install: ## Install all dependencies
	@echo "Installing backend dependencies..."
	cd backend && npm install
	@echo "Installing frontend dependencies..."
	cd frontend && npm install
	@echo "✅ Dependencies installed"

setup: install ## Setup project (install + env files)
	@echo "Setting up environment files..."
	cp backend/.env.example backend/.env
	cp frontend/.env.local.example frontend/.env.local
	cp .env.example .env
	@echo "⚠️  Please update .env files with your actual credentials"
	@echo "✅ Setup complete"

dev: ## Start development servers
	@echo "Starting development environment..."
	docker-compose up -d postgres redis
	@echo "Waiting for database..."
	sleep 5
	cd backend && npx prisma migrate dev && npm run dev &
	cd frontend && npm run dev

build: ## Build all services
	@echo "Building backend..."
	cd backend && npm run build
	@echo "Building frontend..."
	cd frontend && npm run build
	@echo "✅ Build complete"

docker-build: ## Build Docker images
	docker-compose build

docker-up: ## Start all services with Docker
	docker-compose up -d
	@echo "✅ All services started"
	@echo "Backend: http://localhost:5000"
	@echo "Frontend: http://localhost:3000"

docker-down: ## Stop all Docker services
	docker-compose down

docker-logs: ## Show Docker logs
	docker-compose logs -f

seed: ## Seed the database
	cd backend && npm run seed

prisma-migrate: ## Run Prisma migrations
	cd backend && npx prisma migrate dev

prisma-studio: ## Open Prisma Studio
	cd backend && npx prisma studio

test: ## Run all tests
	@echo "Running backend tests..."
	cd backend && npm test
	@echo "Running frontend tests..."
	cd frontend && npm test

clean: ## Clean all dependencies and build artifacts
	@echo "Cleaning..."
	rm -rf backend/node_modules backend/dist
	rm -rf frontend/node_modules frontend/.next
	docker-compose down -v
	@echo "✅ Cleaned"
