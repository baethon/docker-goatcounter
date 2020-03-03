FROM golang:buster AS build

ARG GIT_CI_REF=master

RUN git clone https://github.com/zgoat/goatcounter.git
RUN cd goatcounter \
  && git checkout $GIT_CI_REF \
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
COPY entrypoint.sh /entrypoint.sh

VOLUME ["/goatcounter/db"]
EXPOSE 8080

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/goatcounter/goatcounter.sh"]
