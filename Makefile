###################################################################################################
# Local
###################################################################################################
start:
	npm start

setup: prepare build

install:
	npm clean-install

build:
	npm run build

prepare:
	cp -n .env.ci .env || true

lint:
	npx eslint .

test:
	npm test -s

hadolint:
	 docker run --rm -i hadolint/hadolint hadolint - < $(dockerfilepath)

###################################################################################################
# Dev
###################################################################################################
compose:
	cp -n .env.ci .env || true
	docker-compose -f docker-compose.yml down -v
	docker-compose -f docker-compose.yml up -d

compose-down:
	docker-compose -f docker-compose.yml down

compose-logs-app:
	docker-compose -f docker-compose.yml logs --follow app
compose-logs-db:
	docker-compose -f docker-compose.yml logs --follow db

compose-psql:
	 docker-compose -f docker-compose.yml exec db psql postgres -U postgres

compose-bash:
	 docker-compose -f docker-compose.yml exec app bash

###################################################################################################
# CI
###################################################################################################
compose-ci-up:
	cp -n .env.ci .env || true
	docker-compose up --build

compose-ci-lint:
	docker-compose exec -T app make lint

compose-ci-test:
	docker-compose exec -T app make test
