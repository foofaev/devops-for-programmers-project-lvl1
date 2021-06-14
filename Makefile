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
	cp -n .env.ci .env

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
	docker-compose down -v
	docker-compose up --build -d

compose-down:
	docker-compose down

compose-logs-app:
	docker-compose logs --follow app
compose-logs-db:
	docker-compose logs --follow db

compose-psql:
	docker-compose exec db psql postgres -U postgres

compose-bash:
	docker-compose exec app bash

###################################################################################################
# CI
###################################################################################################
compose-ci:
	docker-compose -f docker-compose.yml up --build --abort-on-container-exit
