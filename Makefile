all: bin

# You can also use Go versions that use go modules (e.g: 1.22)
GO_VERSION := 1.9

img-build:
	docker build -t go-build:${GO_VERSION} --build-arg GO_VERSION=${GO_VERSION} .

dev: img-build
	docker run --rm --name go-build -it \
	--user "$(id -u)":"$(id -g)" \
	-v "$(PWD)":/usr/src/myapp -w /usr/src/myapp \
	go-build:${GO_VERSION} /bin/sh

go-build:
	GO111MODULE=off  go build -o ./build/hello -ldflags "-s -w"

bin: img-build
	docker run --name go-build-tmp \
	  go-build:${GO_VERSION} /bin/sh -c "make go-build" ; \
	docker cp go-build-tmp:/usr/src/myapp/build/. . ; \
	docker stop go-build-tmp && docker rm go-build-tmp
