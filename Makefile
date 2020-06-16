init:
	pip install -r requirements.txt

test:
	py.test tests

freeze:
	pip freeze > requirements.txt

build:
	docker build -t aberegov/capsholder:latest .

run:
	mkdir -p ~/databases
	docker run -d -v ~/databases:/data aberegov/capsholder

shell:
	docker run -ti aberegov/capsholder /bin/bash

.PHONY: init test freeze build run shell
