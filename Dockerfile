ARG GO_VERSION=1.9

FROM golang:${GO_VERSION}

WORKDIR /usr/src/myapp

COPY Makefile .

COPY . .

CMD ["go", "build", "-ldflags \"-s -w\""]
