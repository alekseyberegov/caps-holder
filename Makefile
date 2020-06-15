init:
	pip install -r requirements.txt

test:
	py.test tests

freeze:
	pip freeze > requirements.txt

build:
	docker build -t aberegov/capsholder:latest .

run:
	docker run -p 8080:9000 -d aberegov/capsholder

shell:
	docker run -ti aberegov/capsholder /bin/bash

.PHONY: init test freeze build run shell