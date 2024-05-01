FROM golang:1.9

WORKDIR /usr/src/myapp

COPY Makefile .

COPY . .

CMD ["go", "build", "-ldflags \"-s -w\""]
