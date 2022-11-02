.PHONY: build clean

TAG = 0.0.1

build:
	docker build -t ghcr.io/laika/latex-env:$(TAG) .

run:
	docker run -u $(shell id -u):$(shell id -g) --rm -v $(shell pwd)/workdir:/workdir latex-env:$(TAG) latexmk main.tex

upload:
	docker push ghcr.io/laika/latex-env:$(TAG)
