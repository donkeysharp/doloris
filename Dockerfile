FROM golang:1.12.0-alpine3.9 as builder
LABEL maintainer=serguimant@gmail.com

COPY ./goloris.go /srv
WORKDIR /srv
RUN go build -o /srv/goloris goloris.go


FROM alpine:latest
LABEL maintainer=serguimant@gmail.com

RUN apk update \
    && apk add --no-cache bash vim curl wget

COPY --from=builder /srv/goloris /usr/bin/goloris
COPY ./scripts/wrapper.sh /usr/bin/wrapper.sh

ENTRYPOINT ["wrapper.sh"]
