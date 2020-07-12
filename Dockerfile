FROM tomsquest/docker-radicale

RUN apk add make jq
RUN apk add util-linux

WORKDIR /

COPY production.mk $WORKDIR
COPY Makefile $WORKDIR
COPY .Radicale.props.jq $WORKDIR

# CMD radicale --server-hosts 0.0.0.0:$PORT --config /config/config

