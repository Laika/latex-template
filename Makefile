.PHONY: build clean

TAG = 0.0.3
NAME = latex-env

build:
	docker build -t ghcr.io/laika/$(NAME):$(TAG) .

run:
	docker run -u $(shell id -u):$(shell id -g) --rm -v $(shell pwd)/workdir:/workdir ghcr.io/laika/$(NAME):$(TAG) latexmk main.tex

upload:
	docker push ghcr.io/laika/$(NAME):$(TAG)
