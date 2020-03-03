FROM golang:buster AS build

# RUN apt updaapk add --no-cache git gcc libc-dev
RUN git clone https://github.com/zgoat/goatcounter.git
RUN cd goatcounter \
  && go build ./cmd/goatcounter

FROM debian:buster-slim

WORKDIR /goatcounter

ENV GOATCOUNTER_LISTEN '0.0.0.0:8080'
ENV GOATCOUNTER_DB 'sqlite:///goatcounter/db/goatcounter.sqlite3'

RUN apt-get update \
  && apt-get install -y ca-certificates \
  && update-ca-certificates --fresh

COPY --from=build /go/goatcounter/goatcounter /usr/bin/goatcounter
COPY goatcounter.sh ./
COPY goatcounter-init.sh /usr/bin/goatcounter-init

VOLUME ["/goatcounter/db"]
EXPOSE 8080

CMD ["/goatcounter/goatcounter.sh"]
