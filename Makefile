up:
	docker compose up -d

build:
	docker compose up --build -d

stop:
	docker compose stop

bash:
	docker compose exec app bash

logs:
	docker compose logs -f app

test:
	docker compose exec app php bin/phpunit

cs:
	docker compose exec app ./vendor/bin/php-cs-fixer fix --dry-run --diff

phpstan:
	docker compose exec app ./vendor/bin/phpstan analyse src --level=max
