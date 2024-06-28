FROM golang:1.20-alpine3.18 AS builder

WORKDIR app

COPY . .

RUN apk add --no-cache gcc libc-dev alsa-lib-dev
RUN go mod download \
	&& go build

FROM golang:1.20-alpine3.18 AS final

WORKDIR app

COPY --from=builder /go/app/NitroSniperGo /app/NitroSniperGo

RUN apk add --no-cache alsa-lib-dev

CMD ["/app/NitroSniperGo"]
