.PHONY: mysql redash

mysql:
	docker compose up -d mysql

redash:
	docker compose up -d redash
	docker compose run --rm redash create_db

down:
	docker compose down

reset:
	docker compose down -v
	make mysql

logs:
	docker compose logs -f
