all: docker-build

include .env

go-build:
	GO111MODULE=off  go build -o ./build/hello_go_${GO_VERSION} -ldflags "-s -w" ; chown -R 1000 ./build

docker-build:
	docker compose run --rm --build go-build
#	cp -r ./build/. .
