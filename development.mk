
build:
	PORT=$(PORT) docker build -t radicale:latest .

run: build
	docker run -p $(PORT):$(PORT) -v $(shell pwd)/data:/data --name radical_test -d radicale:latest

test:
	docker exec -it radical_test make -e DOMAIN=test

clean:
	docker stop radical_test
	docker rm radical_test
