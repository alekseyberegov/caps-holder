init:
	pip install -r requirements.txt

test:
	py.test tests

freeze:
	pip freeze > requirements.txt

docker_build:
	docker build -t aberegov/capsholder:latest .

docker_run:
	mkdir -p ~/databases
	docker run -d -v ~/databases:/data aberegov/capsholder

docker_sh:
	docker run -ti aberegov/capsholder /bin/bash

.PHONY: init test freeze docker_build docker_run docker_sh

