CONTAINER = fastapi-websocket-container
IMAGE = fastapi-websocket-image
PORT = 8080
CONTAINER_ID = $(shell docker ps -a --format '{{.ID}}' --filter name=$(CONTAINER))

clean:
	docker stop $(CONTAINER_ID)
	docker rm $(CONTAINER_ID)
	rm -rf app/__pycache__

build:
	docker build -t $(IMAGE) .

deploy: build
	docker run -d --name $(CONTAINER) -p $(PORT):$(PORT) $(IMAGE)

test:
	cd app; uvicorn main:app --reload --port $(PORT)