all: bin

img-build:
	docker build -t go-build:1.9 .

dev: img-build
	docker run --rm --name go-build -it \
	--user "$(id -u)":"$(id -g)" \
	-v "$(PWD)":/usr/src/myapp -w /usr/src/myapp \
	go-build:1.9 /bin/sh

go-build:
	go build -o ./build/hello -ldflags "-s -w"

bin: img-build
	docker run --name go-build-tmp \
	  go-build:1.9 /bin/sh -c "make go-build" ; \
	docker cp go-build-tmp:/usr/src/myapp/build/. . ; \
	docker stop go-build-tmp && docker rm go-build-tmp
