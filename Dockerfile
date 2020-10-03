FROM bitwalker/alpine-elixir:latest AS builder

ENV HEX_HTTP_CONCURRENCY=1
ENV DATABASE_URL=${DATABASE_URL}
ENV SECRET_KEY_BASE=${SECRET_KEY_BASE}

EXPOSE ${PORT}

ENV MIX_ENV=prod \
  LANG=C.UTF-8 \
  PATH=/root/.mix/escripts:$PATH


WORKDIR /src
COPY . .

RUN apk add --no-cache git build-base
RUN mix do local.hex --force, local.rebar --force
RUN mix do deps.get, compile, phx.digest, release

RUN mv _build/$MIX_ENV/rel/misobo /built

FROM alpine:3.11
ENV REPLACE_OS_VARS true

WORKDIR /app
COPY --from=builder built .

RUN apk add --no-cache bash openssl htop
CMD bin/misobo start
