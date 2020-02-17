FROM golang:1.13-alpine3.10 as builder

RUN apk --no-cache --no-progress add make git

WORKDIR /go/src/golang-test
ADD . /go/src/golang-test
RUN go build
RUN ls -l

FROM alpine:3.10
RUN apk update \
    && apk add --no-cache ca-certificates tzdata \
    && update-ca-certificates

WORKDIR /app
COPY --from=builder /go/src/golang-test /app
ENTRYPOINT [ "./golang-test" ]
