FROM golang:1.17-alpine3.15 as build
WORKDIR /usr/src/build

# pre-copy/cache go.mod for pre-downloading dependencies and only redownloading them in subsequent builds if they change
COPY go.mod .
RUN go mod download && go mod verify

# Copiando o fonte
COPY main.go .
RUN go build -v -o bin/app

FROM scratch
COPY --from=build /usr/src/build/bin/app .
CMD [ "./app" ]