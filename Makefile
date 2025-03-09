VERSION=1.1.1

export:
	docker save -o mtranserver.image.tar xxnuo/mtranserver:latest

build:
	cp ../MTranServerCore/dist/core ./core
	docker build -t xxnuo/mtranserver:$(VERSION) .
	docker tag xxnuo/mtranserver:$(VERSION) xxnuo/mtranserver:latest
	docker tag xxnuo/mtranserver:$(VERSION) ghcr.io/xxnuo/mtranserver:$(VERSION)
	docker tag ghcr.io/xxnuo/mtranserver:$(VERSION) ghcr.io/xxnuo/mtranserver:latest

push: build export
	docker login ghcr.io
	docker push ghcr.io/xxnuo/mtranserver:$(VERSION)
	docker push ghcr.io/xxnuo/mtranserver:latest
	
	docker login
	docker push xxnuo/mtranserver:$(VERSION)
	docker push xxnuo/mtranserver:latest
	
import:
	docker load -i mtranserver.image.tar

test:
	cd example/mtranserver && docker compose down && docker compose up

run:
	cd example/mtranserver && docker compose down && docker compose up -d

.PHONY: build run export import push test
