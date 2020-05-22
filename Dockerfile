FROM golang:alpine as builder
RUN apk update && apk upgrade && \
    apk add --no-cache git

ADD ./ /go/src/discordlfm
WORKDIR /go/src/discordlfm

RUN go get ./
RUN go build -o discordlfm ./

FROM alpine
COPY --from=builder /go/src/discordlfm/entrypoint.sh /app/
COPY --from=builder /go/src/discordlfm/discordlfm /app/
WORKDIR /app
CMD ["./entrypoint.sh"]