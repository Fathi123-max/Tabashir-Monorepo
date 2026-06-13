.PHONY: dev-web dev-mobile dev-backend db-push db-migrate db-seed test-web test-mobile test-backend lint format clean

# ─── Frontend (Next.js) ────────────────────────────────────────
dev-web:
	cd tabashir-frontend && pnpm dev

lint-web:
	cd tabashir-frontend && pnpm lint

typecheck-web:
	cd tabashir-frontend && pnpm typecheck

test-web:
	cd tabashir-frontend && pnpm test

# ─── Mobile (Flutter) ──────────────────────────────────────────
dev-mobile:
	cd tabashir-mobile && flutter run

analyze-mobile:
	cd tabashir-mobile && flutter analyze

test-mobile:
	cd tabashir-mobile && flutter test

codegen-mobile:
	cd tabashir-mobile && dart run build_runner build --delete-conflicting-outputs

# ─── Backend (Flask) ───────────────────────────────────────────
dev-backend:
	cd tabashir-backend && python run.py

test-backend:
	cd tabashir-backend && pytest

# ─── Database ──────────────────────────────────────────────────
db-push:
	cd tabashir-frontend && pnpm prisma db push

db-migrate:
	cd tabashir-frontend && pnpm prisma migrate dev

db-seed:
	cd tabashir-frontend && pnpm seed

db-studio:
	cd tabashir-frontend && pnpm prisma studio

# ─── Docker ────────────────────────────────────────────────────
up:
	docker compose up -d

down:
	docker compose down

# ─── Utilities ─────────────────────────────────────────────────
format:
	cd tabashir-mobile && dart format .

clean:
	cd tabashir-frontend && rm -rf .next
	cd tabashir-mobile && flutter clean
