all: build

build:
	docker build -t pg11:latest .

tag:
	docker tag pg11:latest dbreedt/postgres-11-postgis:latest

push:
	docker push dbreedt/postgres-11-postgis:latest

update: build tag push
